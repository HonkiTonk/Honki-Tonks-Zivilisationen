pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen;
with KartenRecords;

package KartengeneratorRecordKonstanten is
   
   Eisrand : constant KartenDatentypen.PolregionenArray := (
                                                            KartenDatentypen.Norden_Enum => 1,
                                                            KartenDatentypen.Süden_Enum  => 1,
                                                            KartenDatentypen.Westen_Enum => 0,
                                                            KartenDatentypen.Osten_Enum  => 0
                                                           );
   
   type KartenartgrößenArray is array (KartenDatentypen.Kartenart_Normal_Enum'Range) of KartenRecords.LandgrößenRecord;
   Kartenartgrößen : constant KartenartgrößenArray := (
                                                           KartenDatentypen.Kartenart_Inseln_Enum =>
                                                             (
                                                              MinimaleYAchse => 3,
                                                              MaximaleYAchse => 4,
                                                              MinimaleXAchse => 3,
                                                              MaximaleXAchse => 4
                                                             ),
                                                           
                                                           KartenDatentypen.Kartenart_Kontinente_Enum =>
                                                             (
                                                              MinimaleYAchse => 5,
                                                              MaximaleYAchse => 8,
                                                              MinimaleXAchse => 5,
                                                              MaximaleXAchse => 8
                                                             ),
                                                           
                                                           KartenDatentypen.Kartenart_Pangäa_Enum =>
                                                             (
                                                              MinimaleYAchse => KartenDatentypen.KartenfeldPositiv'Last,
                                                              MaximaleYAchse => KartenDatentypen.KartenfeldPositiv'Last,
                                                              MinimaleXAchse => KartenDatentypen.KartenfeldPositiv'Last,
                                                              MaximaleXAchse => KartenDatentypen.KartenfeldPositiv'Last
                                                             )
                                                          );

end KartengeneratorRecordKonstanten;
