import numpy as np # linear algebra
import pandas as pd # data processing, CSV file I/O (e.g. pd.read_csv)

MEAN_NUM_ROWS = 60

def calculate_upanddown_mean(df: pd.DataFrame):
    ask_upevent_mean = 0
    count_upevent = 0
    ask_downevent_mean = 0
    count_downevent = 0
    t_up_event = []
    t_down_event = []
    for index, name in df.items():
        if index == 0:
            continue
        if(df[index] > df[index - 1]):
            count_upevent = count_upevent + 1
            t_up_event.append(index)
            ask_upevent_mean = ask_upevent_mean + (df[index] - df[index - 1])
        else: 
            count_downevent = count_downevent + 1
            t_down_event.append(index)
            ask_downevent_mean = ask_downevent_mean + (df[index - 1] - df[index])


    ask_upevent_mean = ask_upevent_mean/count_upevent
    ask_downevent_mean = ask_downevent_mean/count_downevent
    return [ask_upevent_mean, ask_downevent_mean, t_up_event, t_down_event]


dec_test = np.loadtxt('./Test_Dst_NoAuction_DecPre_CF_9.txt')

dfnp = dec_test[:40, :].T
df = pd.DataFrame(dfnp)


dfAskPricesLv1 = df.loc[:MEAN_NUM_ROWS - 1, 0]
dfAskVolumesLv1 = df.loc[:MEAN_NUM_ROWS - 1, 1]

dfBidPricesLv1 = df.loc[:MEAN_NUM_ROWS - 1, 2]
dfBidVolumesLv1 = df.loc[:MEAN_NUM_ROWS - 1, 3]

print(dfAskVolumesLv1)
print(dfBidVolumesLv1)

dfAskVolumesLv1.reset_index()
dfBidVolumesLv1.reset_index()

[ask_upevent_mean, ask_downevent_mean, ask_t_upevent, ask_t_downevent] = calculate_upanddown_mean(dfAskVolumesLv1)
[bid_upevent_mean, bid_downevent_mean, bid_t_upevent, bid_t_downevent] = calculate_upanddown_mean(dfBidVolumesLv1)

print("Média dos Volumes de Ask de Nível 1")
print("Eventos de subida: ")
print(ask_upevent_mean)
print("Eventos de descida: ")
print(ask_downevent_mean)

print("\nMédia dos Volumes de Bid de Nível 1")
print("Eventos de subida: ")
print(bid_upevent_mean)
print("Eventos de descida: ")
print(bid_downevent_mean)

print("Janela de tempo (T):")
print(dfAskVolumesLv1.__len__)

print("Tempos de subida do Ask:")
print(ask_t_upevent)
print("Tempos de descida do Ask:")
print(ask_t_downevent)
print("Tempos de subida do Bid:")
print(bid_t_upevent)
print("Tempos de descida do Bid:")
print(bid_t_downevent)