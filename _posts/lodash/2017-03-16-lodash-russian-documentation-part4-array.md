---
title: Lodash документация на русском (массивы) часть 4
layout: post
categories: Lodash
tags: Lodash Documentation
description: >-
  Перевод документации библиотеки Lodash. Это четвертая часть посвященная
  переводу методов работы с Массивами в которой представлено 7 методов, которые
  помогут вам в работе с массивами.
excerpt_text: >-
  Перевод документации библиотеки Lodash. Это четвертая часть посвященная
  переводу методов работы с Массивами в которой представлено 7 методов, которые
  помогут вам в работе с массивами.  Рассмотрены следующие  методы .pullAllWith
  .pullAt .remove .reverse .slice .sortedIndex .sortedIndexBy
published: true
---

![Lodash документация на русском](/images/post/Lodash/Lo-Dash_array_part4.jpg)

* TOC
{:toc}

# “Массивы” - часть 4

## .pullAllWith(array, values, [comparator])

[source](https://github.com/lodash/lodash/blob/4.17.4/lodash.js#L7795),
[npm package](https://www.npmjs.com/package/lodash.pullallwith).

Этот метод подобен [_.pullAll](https://lodash.com/docs/4.17.4#pullAll) кроме этого он принимает `comparator`, который вызывается, чтобы сравнить элементы от `array` до `values`. Вызов `comparator` производится с двумя аргументами: (arrVal, othVal).

**Заметка:**

Unlike [_.differenceWith](https://lodash.com/docs/4.17.4#differenceWith), this method mutates array.

**Версия:** *4.6.0*

**Аргументы**

`array (Array)`: Массив для обработки.
`values (Array)`: Значения для удаления.
`[comparator] (Function)`: `comparator`  ссылаться на элемент.

**Возвращает**

`(Array)`: Возвращает массив.

### Пример

```javascript

var array = [{ 'x': 1, 'y': 2 }, { 'x': 3, 'y': 4 }, { 'x': 5, 'y': 6 }];
 
_.pullAllWith(array, [{ 'x': 3, 'y': 4 }], _.isEqual);
console.log(array);
// => [{ 'x': 1, 'y': 2 }, { 'x': 5, 'y': 6 }]

```

## .pullAt(array, [indexes])

[source](https://github.com/lodash/lodash/blob/4.17.4/lodash.js#L7825),
[npm package](https://www.npmjs.com/package/lodash.pullat).

Удаляет элементы из `array`, соответствующие по индексам, и возвращает массив из удаленных элементов.

**Заметка:**

В отличие от [_.at](https://lodash.com/docs/4.17.4#at), этот метод изменяет массив.

**Версия:** *3.0.0*

**Аргументы**

`array (Array)`: Массив для изменения.
`[indexes] (...(number|number[]))`: Индексы элементов, которые будут удалять.

**Возвращает**

`(Array)`: Возвращает новый массив из удаленных элементов.

### Пример

```javascript

var array = ['a', 'b', 'c', 'd'];
var pulled = _.pullAt(array, [1, 3]);
 
console.log(array);
// => ['a', 'c']
 
console.log(pulled);
// => ['b', 'd']

```

## .remove(array, [predicate=_.identity])

[source](https://github.com/lodash/lodash/blob/4.17.4/lodash.js#L7864),
[npm package](https://www.npmjs.com/package/lodash.remove).

Удаляет все элементы из массива `predicate`, который возвращает истину и возвращает массив из удаленных элементов. 

`predicate` вызывается с тремя аргументами: (value, index, array).

**Заметка:**

В отличие от [_.at](https://lodash.com/docs/4.17.4#at), этот метод изменяет массив.

**Версия:** *3.0.0*

**Аргументы**

`array (Array)`: Массив для изменения.
`[indexes] (...(number|number[]))`: Индексы элементов, которые будут удалены.

**Возвращает**

`(Array)`: Возвращает новый массив из удаленных элементов.

### Пример

```javascript

var array = ['a', 'b', 'c', 'd'];
var pulled = _.pullAt(array, [1, 3]);
 
console.log(array);
// => ['a', 'c']
 
console.log(pulled);
// => ['b', 'd']

```

## .reverse(array)

[source](https://github.com/lodash/lodash/blob/4.17.4/lodash.js#L7908),
[npm package](https://www.npmjs.com/package/lodash.reverse).

Изменяет массив так, что первый элемент становится последним, второй элемент станет предпоследним и так далее.

**Заметка:**

Этот метод изменяет массив и основан на
[Array#reverse](https://mdn.io/Array/reverse).

**Версия:** *4.0.0*

**Аргументы**

`array (Array)`: Массив для изменения.

**Возвращает**

`(Array)`: Возвращает массив.

### Пример

```javascript

var array = [1, 2, 3];
 
_.reverse(array);
// => [3, 2, 1]
 
console.log(array);
// => [3, 2, 1]

```

## .slice(array, [start=0], [end=array.length])

[source](https://github.com/lodash/lodash/blob/4.17.4/lodash.js#L7928),
[npm package](https://www.npmjs.com/package/lodash.slice).

Создает срез массива от начала до, но не включая конец.

**Заметка:**

Этот метод используется вместо [Array#slice](https://mdn.io/Array/slice), чтобы обеспечить плотность возвращаемому массиву.


**Версия:** *3.0.0*

**Аргументы**

`array (Array)`: Массив для срезки.
`[start=0] (number)`: Стартовая позиция.
`[end=array.length] (number)`: Конечная позиция.

**Возвращает**

`(Array)`: Возвращает срез массива.


## .sortedIndex(array, value)

[source](https://github.com/lodash/lodash/blob/4.17.4/lodash.js#L7961),
[npm package](https://www.npmjs.com/package/lodash.sortedindex).

Использует двоичный поиск, чтобы определить самый низкий показатель, в котором значения должны быть вставлены в массив для того, чтобы сохранить свой порядок сортировки.

**Версия:** *0.1.0*

**Аргументы**

`array (Array)`: Отсортированный массив для проверки.
`value (*)`: Значение для оценки.

**Возвращает**

`(number)`: Возвращает индекс значения, которое должно быть вставлено в массив.

### Пример

```javascript

_.sortedIndex([30, 50], 40);
// => 1

```

## .sortedIndexBy(array, value, [iteratee=_.identity])

[source](https://github.com/lodash/lodash/blob/4.17.4/lodash.js#L7990),
[npm package](https://www.npmjs.com/package/lodash.sortedindexby).

В отличие от [_.sortedIndex](https://lodash.com/docs/4.17.4#sortedIndex) за исключением того, что он принимает `iteratee`, который вызывается по значению и для каждого элемента массива для вычисления их корректного ранжирования. 

`iteratee` вызывается с одним аргументом: (value).

**Версия:** *4.0.0*

**Аргументы**

`array (Array)`: Отсортированный массив для проверки.
`value (*)`: Значение для оценки.
`[iteratee=_.identity] (Function)`: `iteratee` ссылаться на элемент.

**Возвращает**

`(number)`: Возвращает индекс, на какое значение должен быть вставлен в массив.

### Пример

```javascript

var objects = [{ 'x': 4 }, { 'x': 5 }];
 
_.sortedIndexBy(objects, { 'x': 4 }, function(o) { return o.x; });
// => 0
 
// The `_.property` iteratee shorthand.
_.sortedIndexBy(objects, { 'x': 4 }, 'x');
// => 0

```


[Часть 1](http://vaeum.com/blog/2017/02/18/lodash-russian-documentation-part1-array/)
[Часть 2](http://vaeum.com/blog/2017/02/23/lodash-russian-documentation-part2-array/)
[Часть 3](http://vaeum.com/blog/2017/02/26/lodash-russian-documentation-part3-array/)
[Часть 5](http://vaeum.com/blog/2017/03/16/lodash-russian-documentation-part5-array/)
[Часть 6](http://vaeum.com/blog/2017/03/17/lodash-russian-documentation-part6-array/)
[Все методы Массивов](http://vaeum.com/blog/2017/03/18/lodash-russian-documentation-array/)
