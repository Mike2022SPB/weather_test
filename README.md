# README

Список необходимых шагов для полной роботоспособности приложения

1. Скачать .zip либо запулить файлы из этого репозитория

2. Изменить название файла с .env.example на .env и при необходимости заполнить своими данными

3. Выполнить в консоли комманды:


`bundle`


`rails db:create db:migrate db:seed`


`rails generate rspec:install`


4. Запустить сервер используя следующую комманду:

`rails s -b 0.0.0.0 -p 3010`

5. Провести тестирование используя комманду:

`bundle exec rspec`

6. Доступные для обращения эндпоинты:

[http://localhost:3010/weather/current](http://localhost:3010/weather/current)

[http://localhost:3010/weather/historical](http://localhost:3010/weather/historical)

[http://localhost:3010/weather/historical/max](http://localhost:3010/weather/historical/max)

[http://localhost:3010/weather/historical/min](http://localhost:3010/weather/historical/min)

[http://localhost:3010/weather/historical/avg](http://localhost:3010/weather/historical/avg)

[http://localhost:3010/weather/by_time/1702648980](http://localhost:3010/weather/by_time/1702648980) - как пример, однако будет найден он или нет, зависит от того, находиться ли timestamp в БД.

[http://localhost:3010/health](http://localhost:3010/health)

