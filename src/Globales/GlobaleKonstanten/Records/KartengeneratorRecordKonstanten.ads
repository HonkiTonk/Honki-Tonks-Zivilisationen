with KartenDatentypen;
with KartenRecords;
with KartenartDatentypen;

package KartengeneratorRecordKonstanten is
   pragma Pure;
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;
   
   type SenkrechtePolregionenArray is array (KartenartDatentypen.Senkrechte_Himmelsrichtungen_Enum'Range) of KartenDatentypen.SenkrechteNatural;
   SenkrechterEisrand : constant SenkrechtePolregionenArray := (
                                                                KartenartDatentypen.Norden_Enum => 1,
                                                                KartenartDatentypen.Süden_Enum  => 1
                                                               );
   
   type WaagerechtePolregionenArray is array (KartenartDatentypen.Waagerechte_Himmelsrichtungen_Enum'Range) of KartenDatentypen.WaagerechteNatural;
   WaagerechterEisrand : constant WaagerechtePolregionenArray := (
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
                                                              MinimaleYAchse => KartenDatentypen.SenkrechtePositiv'Last / 3,
                                                              MaximaleYAchse => KartenDatentypen.SenkrechtePositiv'Last / 3,
                                                              MinimaleXAchse => KartenDatentypen.WaagerechtePositiv'Last / 3,
                                                              MaximaleXAchse => KartenDatentypen.WaagerechtePositiv'Last / 3
                                                             )
                                                          );

end KartengeneratorRecordKonstanten;
