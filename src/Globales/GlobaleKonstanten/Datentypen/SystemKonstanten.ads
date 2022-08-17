pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with MenueDatentypen;

package SystemKonstanten is

   LeerAuswahl : constant Natural := 0;

   LängstesMenü : constant Positive := 21;

   type EndeMenüArray is array (MenueDatentypen.Welches_Menü_Vorhanden_Enum'Range) of Positive;
   EndeMenü : constant EndeMenüArray := (
                                           -- Einfache Auswahl, keine Überschrift und kein Zusatztext.
                                           MenueDatentypen.Haupt_Menü_Enum              => 8,
                                           MenueDatentypen.Spiel_Menü_Enum              => 7,

                                           -- Einfache Auswahl und kein Zusatztext.
                                           MenueDatentypen.Optionen_Menü_Enum           => 7,
                                           MenueDatentypen.Einstellungen_Menü_Enum      => 12,
                                           MenueDatentypen.Editoren_Menü_Enum           => 9,
                                           MenueDatentypen.Sonstiges_Menü_Enum          => 7,
                                           MenueDatentypen.Grafik_Menü_Enum             => 8,
                                           MenueDatentypen.Sound_Menü_Enum              => 4,
                                           MenueDatentypen.Debug_Menü_Enum              => 9,

                                           MenueDatentypen.Kartenart_Menü_Enum          => 9,
                                           MenueDatentypen.Kartentemperatur_Menü_Enum   => 8,
                                           MenueDatentypen.Kartenressourcen_Menü_Enum   => 8,
                                           MenueDatentypen.Schwierigkeitsgrad_Menü_Enum => 6,

                                           -- Einfache Auswahl.
                                           MenueDatentypen.Kartengröße_Menü_Enum        => 16,
                                           MenueDatentypen.Rassen_Menü_Enum             => 21,
                                           MenueDatentypen.Kartenpole_Menü_Enum         => 8,

                                           -- Komplexe Auswahl.
                                           MenueDatentypen.Kartenform_Menü_Enum         => 13,

                                           -- Unsortiert.
                                           MenueDatentypen.Steuerung_Menü_Enum          => 46
                                          );

   type EndeAbzugArray is array (EndeMenüArray'Range) of Positive;
   EndeAbzugGrafik : constant EndeAbzugArray := (
                                                 -- Einfache Auswahl, keine Überschrift und kein Zusatztext.
                                                 MenueDatentypen.Haupt_Menü_Enum              => EndeMenü (MenueDatentypen.Haupt_Menü_Enum),
                                                 MenueDatentypen.Spiel_Menü_Enum              => EndeMenü (MenueDatentypen.Spiel_Menü_Enum),

                                                 -- Einfache Auswahl und kein Zusatztext.
                                                 MenueDatentypen.Optionen_Menü_Enum           => EndeMenü (MenueDatentypen.Optionen_Menü_Enum),
                                                 MenueDatentypen.Einstellungen_Menü_Enum      => EndeMenü (MenueDatentypen.Einstellungen_Menü_Enum),
                                                 MenueDatentypen.Editoren_Menü_Enum           => EndeMenü (MenueDatentypen.Editoren_Menü_Enum),
                                                 MenueDatentypen.Sonstiges_Menü_Enum          => EndeMenü (MenueDatentypen.Sonstiges_Menü_Enum),
                                                 MenueDatentypen.Grafik_Menü_Enum             => EndeMenü (MenueDatentypen.Grafik_Menü_Enum),
                                                 MenueDatentypen.Sound_Menü_Enum              => EndeMenü (MenueDatentypen.Sound_Menü_Enum),
                                                 MenueDatentypen.Debug_Menü_Enum              => EndeMenü (MenueDatentypen.Debug_Menü_Enum),

                                                 MenueDatentypen.Kartenart_Menü_Enum          => EndeMenü (MenueDatentypen.Kartenart_Menü_Enum),
                                                 MenueDatentypen.Kartentemperatur_Menü_Enum   => EndeMenü (MenueDatentypen.Kartentemperatur_Menü_Enum),
                                                 MenueDatentypen.Kartenressourcen_Menü_Enum   => EndeMenü (MenueDatentypen.Kartenressourcen_Menü_Enum),
                                                 MenueDatentypen.Schwierigkeitsgrad_Menü_Enum => EndeMenü (MenueDatentypen.Schwierigkeitsgrad_Menü_Enum),

                                                 -- Einfache Auswahl.
                                                 MenueDatentypen.Kartengröße_Menü_Enum        => 14,
                                                 MenueDatentypen.Rassen_Menü_Enum             => EndeMenü (MenueDatentypen.Rassen_Menü_Enum),
                                                 MenueDatentypen.Kartenpole_Menü_Enum         => EndeMenü (MenueDatentypen.Kartenpole_Menü_Enum),

                                                 -- Komplexe Auswahl.
                                                 MenueDatentypen.Kartenform_Menü_Enum         => EndeMenü (MenueDatentypen.Kartenform_Menü_Enum),

                                                 -- Unsortiert.
                                                 MenueDatentypen.Steuerung_Menü_Enum          => EndeMenü (MenueDatentypen.Steuerung_Menü_Enum)
                                                );

end SystemKonstanten;
