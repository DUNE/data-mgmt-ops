import sys
import os
import collections
import re
import json
import logging
from rucio.client.rseclient import RSEClient
from rucio.client.didclient import DIDClient
from rucio.client.replicaclient import ReplicaClient
from kafka import KafkaProducer
from datetime import datetime


rucio_account = 'navila'
# DID Client
didclient  = DIDClient(account = rucio_account)

# Replica Client
replicaclient = ReplicaClient(account = rucio_account)

# RSE Client
rseclient = RSEClient(account = rucio_account)
rselist = rseclient.list_rses()

# kafka scripts
logger = logging.getLogger(__name__)
logging.basicConfig(level=logging.DEBUG, format='%(asctime)s [%(levelname)s] %(name)s - %(message)s')

def vs(doc):
    return json.dumps(doc).encode(encoding='utf-8',errors='replace')

kafka_bootstrap_servers  = ['lssrv03.fnal.gov:9092','lssrv04.fnal.gov:9092', 'lssrv05.fnal.gov:9092']
container_kafka_topic = 'ingest.rucio.container_location'
country_kafka_topic = 'ingest.rucio.country'
scope_kafka_topic = 'ingest.rucio.scope_location'
kafka = KafkaProducer(bootstrap_servers=kafka_bootstrap_servers, value_serializer=vs)

# finds the total country usage within all the containers
def usageby_country():
    usage = 0
    all_rses = rseclient.list_rses()
    country_usage = {}
    rse_by_country = {}
    for rse_usage in all_rses:
        myusage = rseclient.get_rse_usage(rse_usage['rse'])
        for usage_record in myusage:
            if usage_record['source'] == 'rucio':
                usage += usage_record['used']
                try:
                    country_usage[rse_usage['country_name']] += usage_record['used']
                except KeyError:
                    country_usage.update({rse_usage['country_name']: usage_record['used']})
    return country_usage

# Kafka script for usageby_country()
def rucio_usage_by_country(kafka):
    time_today = datetime.today()
    rucio_country_usage = usageby_country()
    usage_per_country = []
    for key in rucio_country_usage:
        usage_per_country.append({'country': key, 'usage': rucio_country_usage[key], 'timestamp':  time_today.isoformat()})
        print(usage_per_country)
        for doc in usage_per_country:
            kafka.send(topic = country_kafka_topic, value = doc)
            kafka.flush(timeout = 300)
rucio_usage_by_country(kafka)


# Updated version of rucio_container_size_summary(). Uses the  approach to call the list_parent_dids once 
# function creates a list of containers and then checks the data scope of the parent did against all of the containers 
# Checks one by one and returns a dictionary of information within the container 
def rucio_container_size_summary(target_container_list):
    per_rse_detail = []
    container_list = []
    container_size_info = []
    total_container_size = 0
    all_rses = rseclient.list_rses()
    for rse in all_rses:
        sumof_datasets = {}
        rse_datasets = replicaclient.list_datasets_per_rse(rse['rse'])
        for dataset in rse_datasets:
            parentdids = didclient.list_parent_dids(scope = dataset['scope'], name = dataset['name'])
            for parentdid_info in parentdids:
                for targetcontainer in target_container_list:
                    if parentdid_info['scope'] == targetcontainer['scope'] and parentdid_info['name'] == targetcontainer['name']:
                        try:
                            sumof_datasets[targetcontainer['name']] += dataset['bytes']
                        except KeyError:
                            sumof_datasets.update({targetcontainer['name']: dataset['bytes']})
        mytoday = datetime.today()
        for targetcontainer in target_container_list:
            if targetcontainer['name'] in sumof_datasets:
                output = {'rse': rse['rse'], 'scope': targetcontainer['scope'],
 'usage': sumof_datasets[targetcontainer['name']], 'timestamp': mytoday.isoformat(), 'country': rse['country_name'], 'container': targetcontainer['name']}
                container_size_info.append(output)

    return container_size_info

# Gives you the usage per scope. 
#This function intentionally does not take inconsideration of duplicate datasets within a container. 
def rucio_scope_size_summary():
    sum_of_scopes = {}
    usage_per_scope = []
    all_rses = rseclient.list_rses()
    for rse in all_rses:
        sumof_datasets = {}
        rse_datasets = replicaclient.list_datasets_per_rse(rse['rse'])
        for dataset in rse_datasets:
               try:
                   sum_of_scopes[dataset['scope']] += dataset['bytes']
               except KeyError:
                   sum_of_scopes.update({dataset['scope']: dataset['bytes']})
        print(sum_of_scopes)
        for key in sum_of_scopes:
            mytoday = datetime.today()
            usage_per_scope.append({'scope': key, 'country': rse['country_name'], 'rse': rse['rse'], 'usage': sum_of_scopes[key],'timestamp': mytoday.isoformat()})
    print(usage_per_scope)
    return usage_per_scope

# Kafka script for for rucio_scope_size_summary
def usage_by_scope(kafka):
    rucio_scope_size = rucio_scope_size_summary()
    for doc in rucio_scope_size:
        logger.debug(doc)
        kafka.send(topic = scope_kafka_topic, value = doc)
        kafka.flush(timeout = 200)
usage_by_scope(kafka)

# Updated version of usage_by_container that calls in container_size_summary() 
def usage_by_container(kafka):
    target_container_list = []
    count = 0
    file1 = open('container_list.txt', 'r')
    for line in file1:
         count += 1
         scope_and_name = line.split(':')
         scope = scope_and_name[0]
         name = scope_and_name[1].strip()
         target_container_list.insert(len(target_container_list), { 'scope': scope , 'name': name })
         container_size = rucio_container_size_summary(target_container_list)
         for doc in container_size:
             logger.debug(doc)
             kafka.send(topic = container_kafka_topic, value = doc)
             kafka.flush(timeout = 300)
 #close files
    file1.close()
usage_by_container(kafka)

# continuation of Kafka Scripts
kafka.close(timeout = 300)
