pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen;
with KartenRecords;
with KartenartDatentypen;

package KartengeneratorRecordKonstanten is
   
   type PolregionenArray is array (KartenartDatentypen.Himmelsrichtungen_Enum'Range) of KartenDatentypen.KartenfeldNatural;
   Eisrand : constant PolregionenArray := (
                                           KartenartDatentypen.Norden_Enum => 1,
                                           KartenartDatentypen.Süden_Enum  => 1,
                                           KartenartDatentypen.Westen_Enum => 0,
                                           KartenartDatentypen.Osten_Enum  => 0
                                          );
   
   type KartenartgrößenArray is array (KartenartDatentypen.Kartenart_Normal_Enum'Range) of KartenRecords.LandgrößenRecord;
   Kartenartgrößen : constant KartenartgrößenArray := (
                                                           KartenartDatentypen.Kartenart_Inseln_Enum =>
                                                             (
                                                              MinimaleYAchse => 3,
                                                              MaximaleYAchse => 4,
                                                              MinimaleXAchse => 3,
                                                              MaximaleXAchse => 4
                                                             ),
                                                           
                                                           KartenartDatentypen.Kartenart_Kontinente_Enum =>
                                                             (
                                                              MinimaleYAchse => 5,
                                                              MaximaleYAchse => 8,
                                                              MinimaleXAchse => 5,
                                                              MaximaleXAchse => 8
                                                             ),
                                                           
                                                           KartenartDatentypen.Kartenart_Pangäa_Enum =>
                                                             (
                                                              MinimaleYAchse => KartenDatentypen.KartenfeldPositiv'Last,
                                                              MaximaleYAchse => KartenDatentypen.KartenfeldPositiv'Last,
                                                              MinimaleXAchse => KartenDatentypen.KartenfeldPositiv'Last,
                                                              MaximaleXAchse => KartenDatentypen.KartenfeldPositiv'Last
                                                             )
                                                          );

end KartengeneratorRecordKonstanten;
