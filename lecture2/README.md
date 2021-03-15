# Последовательность выполения скриптов

- **nds.sql** - основной объём данных для схемы nds;
- **nds_book_to_author.sql** - фикс некоторых таблиц many to many;
- **lecture.sql** - скрипты с лекции

# Описание схемы nds

## sale_item

| колонка | тип данных | описание |
| :------ | :--------- | :--------|
| id | serial | суррогатный id |
| transaction_id | bigint | id транзакции (номер заказа) |
| dt | timestamp | дата и время транзакции |
| store_id | integer | id магазина (ссылка на nds.store) | 
| customer_id | integer | id покупателя (ссылка на nds.customer) |
| line_number | smallint | номер позиции в заказе |
| book_id | bigint | id книги |
| film_id | bigint | id фильма |
| music_id | bigint | id музыкального альбома |
| quantity | smallint | количество |

## book

| колонка | тип данных | описание |
| :------ | :--------- | :--------|
| id | serial | суррогатный ID |
| book_key | bigint | натуральный ID |
| category_id | integer | ID категории (ссылка на nds.book_category) |
| nomenclature | varchar(400) | номенклатура |
| publisher_id | integer | ID издателя (ссылка на nds.book_publisher) |
| year | smallint | год издания |
| pages | smallint | количество страниц |
| binding | varchar(100) | переплёт |
| format | varchar(20) | формат |
| isbn | varchar(40) | ISBN |
| standard | smallint | номенклатура стандарт |
| annotation | varchar(1000) | аннотация |
| vendor_code | bigint | артикул |
| url | varchar(200) | интернет ссылка для EOTR |
| price | double precision | цена |
| cost | double precision | себестоимость |
| status | char | статус (o - offered, e - expired, p - purchased) |
| start_ts | date | начало интервала активности записи |
| end_ts | date | начало интервала активности записи |
| is_current | boolean | флаг активности записи (является ли данная запись актуальной на текущий момент времени) |
| version | integer | версия |

## films

| колонка | тип данных | описание |
| :------ | :--------- | :--------|
| id | serial | суррогатный ID |
| film_key | bigint | натуральный ID |
| title | varchar(400) | название |
| age_id | smallint | ID возрастной категории (ссылка на nds.films_age) |
| category_id | smallint | ID категории (ссылка на nds.films_category) |
| genre_id | bigint | ID жанра (ссылка на nds.films_genre) |
| price | double precision | цена |
| cost | double precision | себестоимость |
| status | char | статус (o - offered, e - expired, p - purchased) |
| start_ts | date | начало интервала активности записи |
| end_ts | date | начало интервала активности записи |
| is_current | boolean | флаг активности записи (является ли данная запись актуальной на текущий момент времени) |
| create_ts | timestamp | дата и время созданя записи (техническое поле) |
| update_ts | timestamp | дата и время созданя записи (техническое поле) |
| version | integer | версия |

## music

| колонка | тип данных | описание |
| :------ | :--------- | :--------|
| id | serial | суррогатный ID |
| music_key | bigint | натуральный ID |
| album | varchar(400) | название пластинки |
| year | smallint | год издания |
| artist_id | bigint | ID артиста (ссылка на nds.artists) |
| price | double precision | цена |
| cost | double precision | себестоимость |
| status | char | статус (o - offered, e - expired, p - purchased) |
| start_ts | date | начало интервала активности записи |
| end_ts | date | начало интервала активности записи |
| is_current | boolean | флаг активности записи (является ли данная запись актуальной на текущий момент времени) |
| create_ts | timestamp | дата и время созданя записи (техническое поле) |
| update_ts | timestamp | дата и время созданя записи (техническое поле) |
| version | integer | версия |
