detach="--rm"

docker run $detach \
    -v /home/rucio/monitoring/logstash/sql_to_es/config/:/usr/share/logstash/config/ \
    -v /home/rucio/monitoring/logstash/sql_to_es/pipeline/:/usr/share/logstash/pipeline/ \
    -v /home/rucio/monitoring/logstash/sql_to_es/java/:/usr/share/logstash/java/ \
    --name logstash docker.elastic.co/logstash/logstash:7.0.0
