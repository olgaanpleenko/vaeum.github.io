---
title: Working with Core Data (Перевод). Часть первая.
layout: post
categories: Swift Xcode CoreData
tags: Swift Xcode CoreData
description: Работа с Core Data.
related:
  - Working with Core Data(Перевод) Часть первая.
published: true
---

![Работа с Core Data.](/images/post/codedata.jpg)

Поздравляю с этим! К настоящему времени вы уже создали простое приложение для пользователей, чтобы перечислить их любимые рестораны. Если вы работали над предыдущим упражнением,то вы должны понять основы того, как добавить ресторан. Я попытался упростить процесс и сосредоточиться на основах **UItableView**. До этого момента все рестораны были предопределены в исходном коде и сохранены в массиве. Если вы хотите сохранить ресторан,то самым простым способом является добавление нового ресторана в существующий массив ресторанов.

Однако, если вы оставите это таким,то вы не сможете сохранить новый ресторан. Удерживание данных в памяти (например, массив) не стабильно. Как только вы выйдите из приложения, все изменения исчезнут. Нам нужно найти способ сохранить данные в постоянном виде. 

Чтобы сохранить данные в постоянном виде, вам нужно будет сохранить их в постоянном хранилище или в базе данных. Например, сохраняя данные в базе, данные будут в безопасности, даже если приложение завершит работу или выйдет из строя. Файлы — это еще один способ сохранения данных, но они больше подходят для хранения небольших объемов данных, которые требуют частых изменений. Например, файлы обычно используются для хранения настроек приложения. Если вы откроете папку **Support Files** в навигаторе проекта,то вы найдете файл **Info.plist**. Этот файл свойств используется для хранения настроек проекта.

Приложению **FoodPin** может потребоваться хранить тысячи записей о ресторанах. Пользователи могут также часто добавлять данные или удалять записи о ресторанах. В этом случае база данных — это подходящий способ обработки большого набора данных. В этой главе я расскажу вам о структуре **Core Data** и покажу, как её использовать для управления данными в базе. Вы внесете много изменений в существующий проект, но после прохождения этой главы, ваше приложение позволит пользователям сохранять свои любимые рестораны.

[Исходный проект.](http://www.appcoda.com/resources/swift3 FoodPinStaticTableViewExercise.zip)

### Что такое Core Data?

Когда мы говорим о постоянных данных, вы, вероятно, думаете о базах данных. Если вы знакомы с **Oracle** или **MySQL**,то вы знаете, что реляционная база данных хранит данные в виде таблиц, строк и столбцов. Ваше приложение обращается к базе с помощью **SQL** (Structured Query Language) запроса. Однако не путайте данные ядра с базами данных. Хотя база данных **SQLite** является постоянным хранилищем по умолчанию для **Core Data** в **IOS**, **Core Data** не является точно реляционной базой данных - на самом деле это платформа, которая позволяет разработчикам взаимодействовать с базой данных (или другим постоянным хранилищем) объектно-ориентированным способом.

Возьмите приложение **FoodPin** в качестве примера. Если вы хотите сохранить данные в базе данных,то вы несете ответственность за написание кода для подключения к базе данных и извлечение или обновление данных с помощью **SQL**. Это было бы обременительно для разработчиков, особенно для тех, кто не знает **SQL**.

**Core Data** обеспечивает более простой способ сохранения данных в постоянном хранилище по вашему выбору. Вы можете сопоставлять объекты в ваших приложениях с таблицей в базе данных. Проще говоря, это позволяет вам управлять записями **(select/insert/update/delete)** в базе данных, даже не зная **SQL**.

### Core Data Stack

Прежде чем мы начнем работу над проектом, вам нужно сначала получить базовое представление о **Core Data Stack**. Смотрите на рисунок.

![Core Data Stack](https://monosnap.com/file/2AXNX3wJ1j9En3fig2xDxzdiltw3fr.png)

* **Managed Object Context** — думайте об этом как о блокноте или временной области памяти, содержащей объекты, которые взаимодействуют с данными в постоянном хранилище. Его задача — управлять объектами, созданными и возвращаемыми с использованием инфраструктуры **Core Data**. Среди компонентов в стеке основных данных контекст управляемого объекта тот, с которым вы будете работать напрямую в большинстве случаев. А когда вам нужно извлекать и сохранять объекты в постоянном хранилище, контекст является первым компонентом, с которым вы будете взаимодействовать.
* **Persistent Store Coordinator** —  **SQLite** является постоянным хранилищем по умолчанию в **IOS**. Однако **Core Data** позволяет разработчикам создавать несколько хранилищ, содержащих разные объекты. Координатор постоянного хранилища — это сторона, ответственная за управление различными хранилищами постоянных объектов и сохранение объектов. Забудьте об этом, если вы не понимаете, что это такое. Вы на прямую не будете взаимодействовать с постоянным координатором при использовании **Core Data**.
* **Managed Object Model** — здесь описывается схема, которую вы используете в приложении. Если у вас есть опыт работы с базами данных, подумайте об этом как о схеме базы данных. Однако схема представлена набором объектов (также называемых сущностями). Например, коллекцию модельных объектов можно использовать для представления коллекции ресторанов в приложении **FoodPin**. В **Xcode** модель управляемых объектов определяется в файле с расширением **.xcdatamodeld**. Вы можете использовать визуальный редактор для определения сущностей, их атрибутов и отношений. 
* **Persistent Store** — это хранилище, в котором ваши данные фактически хранятся. Обычно это база данных **SQLite**, которая обычно является базой данных по умолчанию. Но это также может быть база данных: **Binary** или **XML-файлом**. 

Это выглядит сложно, правда? Определенно. Поэтому в IOS 10 вводится новый класс **NSPersistentContainer**, который упрощает управление стеком основных данных в ваших приложениях. **NSPersistentContainer** — класс, с которым вы будете иметь дело для сохранения и извлечения данных. 
Сбиты с толку? Не беспокойтесь. Вы поймете, что я имею в виду, когда мы сконвертируем приложение **FoodPin** из массивов в **Core Data**.

### Использование шаблона основных данных

Самый простой способ использовать **Core Data** — включить опцию **Core Data** во время создания проекта. **Xcode** будет генерировать требуемый код в **AppDelegate.swift** и создавать модели данных для этого.

![Create Core Data](https://monosnap.com/file/s3xDHmGZ0kqElXe86g5eHEim7Q1ncT.png)

Если вы создадите проект **CoreDataDemo** с включенной опцией **Core Data**,то увидите следующие переменные и метод, сгенерированный в классе **AppDelegate**: 


```swift
// MARK: - Core Data stack
lazy var persistentContainer: NSPersistentContainer = {
    /*
     The persistent container for the application. This implementation
     creates and returns a container, having loaded the store for the
     application to it. This property is optional since there are legitimate
     error conditions that could cause the creation of the store to fail.
*/ 
    let container = NSPersistentContainer(name: "CoreDataDemo")
    container.loadPersistentStores(completionHandler: { (storeDescription,
error) in
        if let error = error as NSError? {
            // Replace this implementation with code to handle the error
appropriately.
            // fatalError() causes the application to generate a crash log and
terminate. You should not use this function in a shipping application, although
it may be useful during development.
            /*
             Typical reasons for an error here include:
             * The parent directory does not exist, cannot be created, or
disallows writing.
             * The persistent store is not accessible, due to permissions or
data protection when the device is locked.
             * The device is out of space.
             * The store could not be migrated to the current model version.
             Check the error message to determine what the actual problem was.
             */
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
}) 
    return container
}()
// MARK: - Core Data Saving support
func saveContext () {
    let context = persistentContainer.viewContext
    if context.hasChanges {
        do {
            try context.save()
} catch { 
            // Replace this implementation with code to handle the error
appropriately.
            // fatalError() causes the application to generate a crash log and
terminate. You should not use this function in a shipping application, although
it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
} } 
```

Сгенерированный код предоставляет переменную и метод:

* Переменная **persistentContainer** является экземпляром **NSPersistentContainer** и инициализирована постоянным хранилищем с именем **CoreDataDemo**. Позже вы будете использовать эту переменную для взаимодействия со стеком **Core Data**.
* Метод **saveContext()** обеспечивает сохранение данных. Когда вам нужно будет вставить/обновить/удалить данные в постоянном хранилище, вы вызовите этот метод.

Если вы использовали **Core Data** в старой версии **Xcode**,то вы должны обнаружить, что сгенерированный код был значительно упрощен. **NSPersistentContainer** инкапсулирует **Core Data stack** и упрощает способ использования основных данных.

Вопрос в том, как мы можем использовать этот шаблон кода в нашем существующем проекте **Xcode**. Мы можете просто скопировать и вставить код в **AppDelegate.swift** вашего проекта, но вам нужно будет внести незначительные изменения. 

```swift
let container = NSPersistentContainer(name: "CoreDataDemo")
```

Исходный шаблон кода был создан для проекта **CoreDataDemo**. **Xcode** называет имя файла **SQLite** и модели данных, используя имя проекта. Для проекта **FoodPin** вместо **CoreDataDemo** пишем имя вашего **FoodPin**. Поэтому измените приведенную строку кода на следующую:

```swift
let container = NSPersistentContainer(name: "FoodPin")
```

Наконец, добавьте оператор **import** в начале класса **AppDelegate**, чтобы импортировать его. **Core Data framework**:

```swift
import CoreData
```

> **Примечание:** Для справки вы также можете загрузить этот [шаблон проекта](http://www.appcoda.com/resources/swift3/FoodPinCoreDataTemplate.zip), чтобы продолжить работу.

На этом перевод первой части главы закончен.

Перевод главы из книги: [Beginning iOS 10 Programming with Swift 3](https://www.amazon.com/Beginning-iOS-10-Programming-Swift/dp/1520222599/ref=sr_1_1?s=books&ie=UTF8&qid=1487189058&sr=1-1&keywords=Simon+Ng)

Автор книги: Simon Ng
