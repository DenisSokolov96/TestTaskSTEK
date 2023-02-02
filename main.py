import pandas as pd
from decimal import Decimal


def readCSVFile(pathName):
    return pd.read_csv(pathName, sep=';')


def writeCSVFile(tableData, pathName):
    tableData.to_csv(pathName,  sep=';', encoding='cp1251', index=False)


if __name__ == '__main__':
    stNorm = Decimal("301.26")
    stEnum = Decimal("1.52")
    tblSubscribCharges = readCSVFile(pathName='data/абоненты.csv')
    accrued = list()
    for i in range(0, len(tblSubscribCharges)):
        if tblSubscribCharges['Тип начисления'][i] == 1:
            accrued.append(stNorm)
            continue
        if tblSubscribCharges['Тип начисления'][i] == 2:
            valueEnum = Decimal((tblSubscribCharges['Текущее'][i] - tblSubscribCharges['Предыдущее'][i]) * stEnum)
            accrued.append(valueEnum)
            continue
    tblSubscribCharges['Начислено'] = accrued
    writeCSVFile(tableData=tblSubscribCharges,
                 pathName='data/Начисления_абоненты.csv')

    tblAccrualsHome = pd.DataFrame(columns=['№ строки', 'Улица', '№ дома', 'Начислено'])
    for i in range(0, len(tblSubscribCharges)):
        tempRow = {
            '№ строки': len(tblAccrualsHome) + 1,
            'Улица': tblSubscribCharges['Улица'][i],
            '№ дома': tblSubscribCharges['№ дома'][i],
            'Начислено': tblSubscribCharges['Начислено'][i]
        }

        flagWrite = False
        for j in range(0, len(tblAccrualsHome)):
            if tblAccrualsHome['Улица'][j] == tempRow['Улица'] and tblAccrualsHome['№ дома'][j] == tempRow['№ дома']:
                tblAccrualsHome.loc[j, 'Начислено'] += tempRow['Начислено']
                flagWrite = True
                break
        if flagWrite is False:
            tblAccrualsHome.loc[len(tblAccrualsHome.index)] = [tempRow['№ строки'], tempRow['Улица'],
                                                               tempRow['№ дома'], tempRow['Начислено']]

    writeCSVFile(tableData=tblAccrualsHome,
                 pathName='data/Начисления_дома.csv')


