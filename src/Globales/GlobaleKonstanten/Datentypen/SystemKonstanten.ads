pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with MenueDatentypen;

package SystemKonstanten is

   LeerAuswahl : constant Natural := 0;

   LängstesMenü : constant Positive := 21;

   -- Diese Konstanten nicht nur für die Menüarrays anlegen sondern für alle? äöü
   type EndeMenüArray is array (MenueDatentypen.Welches_Menü_Vorhanden_Enum'Range) of Positive;
   -- Beim Ändern dieser Werte auch immer auf verwendete Variablen/Konstanten in anderen Dateien achten.
   -- Wenn möglich für Sonderfälle rückwärts zählen, wie z. B. beim Rückgabesystem oder beim Zusatztext für das Kartengrößenmenü.
   EndeMenü : constant EndeMenüArray := (
                                           -- Einfache Auswahl, keine Überschrift und kein Zusatztext.
                                           MenueDatentypen.Haupt_Menü_Enum              => 8,
                                           MenueDatentypen.Spiel_Menü_Enum              => 6,

                                           -- Einfache Auswahl und kein Zusatztext.
                                           MenueDatentypen.Optionen_Menü_Enum           => 7,
                                           MenueDatentypen.Einstellungen_Menü_Enum      => 11,
                                           MenueDatentypen.Editoren_Menü_Enum           => 17,
                                           MenueDatentypen.Sonstiges_Menü_Enum          => 7,
                                           MenueDatentypen.Grafik_Menü_Enum             => 8,
                                           MenueDatentypen.Sound_Menü_Enum              => 7,
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
                                           MenueDatentypen.Steuerung_Menü_Enum          => 91
                                          );

   type EndeAbzugArray is array (EndeMenüArray'Range) of Natural;
   EndeAbzugGrafik : constant EndeAbzugArray := (
                                                 -- Einfache Auswahl, keine Überschrift und kein Zusatztext.
                                                 MenueDatentypen.Haupt_Menü_Enum              => 1,
                                                 MenueDatentypen.Spiel_Menü_Enum              => 0,

                                                 -- Einfache Auswahl und kein Zusatztext.
                                                 MenueDatentypen.Optionen_Menü_Enum           => 0,
                                                 MenueDatentypen.Einstellungen_Menü_Enum      => 0,
                                                 MenueDatentypen.Editoren_Menü_Enum           => 0,
                                                 MenueDatentypen.Sonstiges_Menü_Enum          => 0,
                                                 MenueDatentypen.Grafik_Menü_Enum             => 0,
                                                 MenueDatentypen.Sound_Menü_Enum              => 0,
                                                 MenueDatentypen.Debug_Menü_Enum              => 0,

                                                 MenueDatentypen.Kartenart_Menü_Enum          => 0,
                                                 MenueDatentypen.Kartentemperatur_Menü_Enum   => 0,
                                                 MenueDatentypen.Kartenressourcen_Menü_Enum   => 0,
                                                 MenueDatentypen.Schwierigkeitsgrad_Menü_Enum => 0,

                                                 -- Einfache Auswahl.
                                                 MenueDatentypen.Kartengröße_Menü_Enum        => 3,
                                                 MenueDatentypen.Rassen_Menü_Enum             => 0,
                                                 MenueDatentypen.Kartenpole_Menü_Enum         => 0,

                                                 -- Komplexe Auswahl.
                                                 MenueDatentypen.Kartenform_Menü_Enum         => 0,

                                                 -- Unsortiert.
                                                 MenueDatentypen.Steuerung_Menü_Enum          => 0
                                                );

   EndeAbzugLogik : constant EndeAbzugArray := (
                                                -- Einfache Auswahl, keine Überschrift und kein Zusatztext.
                                                MenueDatentypen.Haupt_Menü_Enum              => 1,
                                                MenueDatentypen.Spiel_Menü_Enum              => 0,

                                                -- Einfache Auswahl und kein Zusatztext.
                                                MenueDatentypen.Optionen_Menü_Enum           => 1,
                                                MenueDatentypen.Einstellungen_Menü_Enum      => 1,
                                                MenueDatentypen.Editoren_Menü_Enum           => 1,
                                                MenueDatentypen.Sonstiges_Menü_Enum          => 1,
                                                MenueDatentypen.Grafik_Menü_Enum             => 1,
                                                MenueDatentypen.Sound_Menü_Enum              => 1,
                                                MenueDatentypen.Debug_Menü_Enum              => 1,

                                                MenueDatentypen.Kartenart_Menü_Enum          => 1,
                                                MenueDatentypen.Kartentemperatur_Menü_Enum   => 1,
                                                MenueDatentypen.Kartenressourcen_Menü_Enum   => 1,
                                                MenueDatentypen.Schwierigkeitsgrad_Menü_Enum => 1,

                                                -- Einfache Auswahl.
                                                MenueDatentypen.Kartengröße_Menü_Enum        => 3,
                                                MenueDatentypen.Rassen_Menü_Enum             => 1,
                                                MenueDatentypen.Kartenpole_Menü_Enum         => 1,

                                                -- Komplexe Auswahl.
                                                MenueDatentypen.Kartenform_Menü_Enum         => 5,

                                                -- Unsortiert.
                                                MenueDatentypen.Steuerung_Menü_Enum          => 1
                                               );

end SystemKonstanten;
