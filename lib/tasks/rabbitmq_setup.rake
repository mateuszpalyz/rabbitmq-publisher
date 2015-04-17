namespace :rabbitmq do
  task :setup do
    connection = Bunny.new
    connection.start

    channel = connection.create_channel
    exchange_fanout = channel.fanout('currencies.fanout')
    exchange_direct = channel.direct('currencies.direct')

    (1..3).each { |i| channel.queue("currencies.queue_#{i}").bind(exchange_fanout) }
    channel.queue('currencies.acknowledgements')
      .bind(exchange_direct, routing_key: 'acknowledgements')

    connection.close
  end
end
