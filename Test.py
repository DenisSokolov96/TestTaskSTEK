from random import randint


# Сортировка пузырьком
def bubleSort():
    n = 20
    mas = [randint(1, 99) for i in range(n)]
    print(mas)

    for i in range(n):
        for j in range(n - 1):
            if mas[j] > mas[j + 1]:
                temp = mas[j]
                mas[j] = mas[j + 1]
                mas[j + 1] = temp
    print(mas)


# Числа Фибоначчи
def fib(n):
    if n in (1, 2):
        return 1
    return fib(n - 1) + fib(n - 2)


# Поиск дублей в массиве
def searcDoubleValuesInMas():
    mas = [1, 2, 3, 4, 5, 2, 3, 4]
    dict = {}
    for n in mas:
        if n not in dict:
            dict[n] = 1
        else:
            dict[n] += 1
    print(dict)


# Определение полиндрома
def polindrom():
    word = str(input())
    reversWord = word[::-1]
    if word == reversWord:
        print("yes")
    else:
        print("no")


def main():
    # bubleSort()
    # print(fib(9))
    # searcDoubleValuesInMas()
    polindrom()


if __name__ == '__main__':
    main()






