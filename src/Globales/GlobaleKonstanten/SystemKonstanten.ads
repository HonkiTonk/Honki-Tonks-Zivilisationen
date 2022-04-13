pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;

package SystemKonstanten is

   type EndeMenüArray is array (SystemDatentypen.Welches_Menü_Vorhanden_Enum'Range) of Positive;
   EndeMenü : constant EndeMenüArray := (
                                           SystemDatentypen.Haupt_Menü_Enum              => 6,
                                           SystemDatentypen.Spiel_Menü_Enum              => 7,

                                           SystemDatentypen.Optionen_Menü_Enum           => 8,
                                           SystemDatentypen.Einstellungen_Menü_Enum      => 11,
                                           SystemDatentypen.Editoren_Menü_Enum           => 17,

                                           SystemDatentypen.Kartengröße_Menü_Enum        => 27,
                                           SystemDatentypen.Kartenart_Menü_Enum          => 8,
                                           SystemDatentypen.Kartentemperatur_Menü_Enum   => 7,
                                           SystemDatentypen.Kartenressourcen_Menü_Enum   => 8,
                                           SystemDatentypen.Schwierigkeitsgrad_Menü_Enum => 6,
                                           SystemDatentypen.Rassen_Menü_Enum             => 41,

                                           SystemDatentypen.Kartenform_Menü_Enum         => 23,

                                           SystemDatentypen.Grafik_Menü_Enum             => 15,
                                           SystemDatentypen.Sound_Menü_Enum              => 7,
                                           SystemDatentypen.Steuerung_Menü_Enum          => 91,
                                           SystemDatentypen.Sonstiges_Menü_Enum          => 13
                                          );

end SystemKonstanten;
