1. **Создание ВМ в Яндекс Облаке с помощью Terraform:**
    - Было создано 3 виртуальные машины (ВМ) в Яндекс Облаке с использованием Terraform.
    - Файлы конфигурации Terraform прилагаются.

2. **Установка Docker на хосты:**
    - На всех хостах был установлен Docker.

3. **Создание мастер-ноды:**
    - На одной из виртуальных машин была инициализирована мастер-нодa с командой:
    
    ```bash
    docker swarm init --advertise-addr 10.0.0.30
    ```

    - В результате выполнения команды был выведен токен для добавления рабочих нод:

    ```bash
    docker swarm join --token SWMTKN-1-0vmqxtysthjf19rhxbdsfb08h53k2hygqdugr1gj5dglo38bmh-9vdb5fgmh6 ycg42f9jxc9ak7g 10.0.0.30:2377
    ```

4. **Добавление рабочих нод:**
    - На остальных двух хостах было выполнено подключение к мастер-ноде с использованием полученного токена:
    
    ```bash
    docker swarm join --token SWMTKN-1-0vmqxtysthjf19rhxbdsfb08h53k2hygqdugr1gj5dglo38bmh-9vdb5fgmh6 ycg42f9jxc9ak7g 10.0.0.30:2377
    ```

5. **Проверка состояния кластера:**
    - После успешного подключения рабочих нод, был выполнен запрос на мастер-ноде:
    
    ```bash
    docker node ls
    ```
    
    - Результат выполнения:

    ```bash
    ID                            HOSTNAME               STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
    azmbfxdiv1up8dsyzuzj06cyq *   fhm4v6o0bq2k44iu86gc   Ready     Active         Leader           27.4.1
    3ibvvth7sxiiw4yor6flysxbo     fhmqt4gu1mc6vk0g78cm   Ready     Active                          27.4.1
    57skubl4uh9fmc3k6i32q5xo7     fhmshfhrn9r4necok8bt   Ready     Active                          27.4.1
    ```

    В этом выводе:
    - `fhm4v6o0bq2k44iu86gc` — мастер-нода, помечена как `Leader`.
    - Остальные ноды (`fhmqt4gu1mc6vk0g78cm` и `fhmshfhrn9r4necok8bt`) являются рабочими нодами.
