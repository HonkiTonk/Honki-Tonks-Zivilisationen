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
                                                              MinimaleSenkrechte => 3,
                                                              MaximaleSenkrechte => 4,
                                                              MinimaleWaagerechte => 3,
                                                              MaximaleWaagerechte => 4
                                                             ),
                                                           
                                                           KartenartDatentypen.Kartenart_Kontinente_Enum =>
                                                             (
                                                              MinimaleSenkrechte => 5,
                                                              MaximaleSenkrechte => 8,
                                                              MinimaleWaagerechte => 5,
                                                              MaximaleWaagerechte => 8
                                                             ),
                                                           
                                                           KartenartDatentypen.Kartenart_Pangäa_Enum =>
                                                             (
                                                              MinimaleSenkrechte => KartenDatentypen.SenkrechtePositiv'Last / 3,
                                                              MaximaleSenkrechte => KartenDatentypen.SenkrechtePositiv'Last / 3,
                                                              MinimaleWaagerechte => KartenDatentypen.WaagerechtePositiv'Last / 3,
                                                              MaximaleWaagerechte => KartenDatentypen.WaagerechtePositiv'Last / 3
                                                             )
                                                          );

end KartengeneratorRecordKonstanten;
