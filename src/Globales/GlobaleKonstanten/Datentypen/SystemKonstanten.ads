pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with MenueDatentypen;

package SystemKonstanten is

   -- Das mit der 0 funktioniert so auch nicht mehr, überarbeiten. äöü
   -- Nur die StadtEinheitenauswahl nutzt das aktuell anders, also das anpassen dann geht es wieder. äöü
   LeerAuswahl : constant Natural := 0;

   StandardArrayanpassung : constant Positive := 2;

   type EndeMenüArray is array (MenueDatentypen.Welches_Menü_Vorhanden_Enum'Range) of Positive;
   EndeMenü : constant EndeMenüArray := (
                                           -- Einfache Menüs.
                                           -- Ohne Überschrift.
                                           MenueDatentypen.Haupt_Menü_Enum              => 8,
                                           MenueDatentypen.Spiel_Menü_Enum              => 7,

                                           -- Mit Überschrift.
                                           MenueDatentypen.Optionen_Menü_Enum           => 8,
                                           MenueDatentypen.Einstellungen_Menü_Enum      => 12,
                                           MenueDatentypen.Editoren_Menü_Enum           => 10,
                                           MenueDatentypen.Sonstiges_Menü_Enum          => 7,
                                           MenueDatentypen.Grafik_Menü_Enum             => 10,
                                           MenueDatentypen.Sound_Menü_Enum              => 4,
                                           MenueDatentypen.Debug_Menü_Enum              => 7,
                                           MenueDatentypen.Kartenart_Menü_Enum          => 9,
                                           MenueDatentypen.Kartentemperatur_Menü_Enum   => 8,
                                           MenueDatentypen.Kartenressourcen_Menü_Enum   => 8,
                                           MenueDatentypen.Schwierigkeitsgrad_Menü_Enum => 6,
                                           MenueDatentypen.Kartengröße_Menü_Enum        => 16,
                                           MenueDatentypen.Diplomatie_Menü_Enum         => 10,
                                           MenueDatentypen.Kartenpole_Menü_Enum         => 8,

                                           -- Doppelte Menüs.
                                           MenueDatentypen.Rassen_Menü_Enum             => 21,
                                           MenueDatentypen.Kartenform_Menü_Enum         => 14,

                                           -- Steuerungsmenü.
                                           MenueDatentypen.Steuerung_Menü_Enum          => 31,

                                           -- Spielstandmenü
                                           MenueDatentypen.Spielstand_Menü_Enum         => 15
                                          );

   -- Theoretich kann man hier noch -1 machen um die Überschrift abzuziehen, wird in den Positionen/Textaccessen nicht mehr benötigt. äöü
   -- Braucht aber diverse Anpassungen, später mal anschauen. äöü
   ZweitlängstesMenü : constant Positive := EndeMenü (MenueDatentypen.Rassen_Menü_Enum);
   LängstesMenü : constant Positive := EndeMenü (MenueDatentypen.Steuerung_Menü_Enum);

   type EndeAbzugArray is array (EndeMenüArray'Range) of Positive;
   EndeAbzugGrafik : constant EndeAbzugArray := (
                                                 -- Einfache Menüs.
                                                 -- Ohne Überschrift.
                                                 MenueDatentypen.Haupt_Menü_Enum              => EndeMenü (MenueDatentypen.Haupt_Menü_Enum),
                                                 MenueDatentypen.Spiel_Menü_Enum              => EndeMenü (MenueDatentypen.Spiel_Menü_Enum),

                                                 -- Mit Überschrift.
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
                                                 MenueDatentypen.Kartengröße_Menü_Enum        => EndeMenü (MenueDatentypen.Kartengröße_Menü_Enum) - 2,
                                                 MenueDatentypen.Diplomatie_Menü_Enum         => EndeMenü (MenueDatentypen.Diplomatie_Menü_Enum) - 2,
                                                 MenueDatentypen.Kartenpole_Menü_Enum         => EndeMenü (MenueDatentypen.Kartenpole_Menü_Enum),

                                                 -- Doppelte Menüs.
                                                 MenueDatentypen.Rassen_Menü_Enum             => EndeMenü (MenueDatentypen.Rassen_Menü_Enum),
                                                 MenueDatentypen.Kartenform_Menü_Enum         => EndeMenü (MenueDatentypen.Kartenform_Menü_Enum) - 4,

                                                 -- Steuerungsmenü.
                                                 MenueDatentypen.Steuerung_Menü_Enum          => EndeMenü (MenueDatentypen.Steuerung_Menü_Enum) - 5,

                                                 -- Spielstandmenü.
                                                 MenueDatentypen.Spielstand_Menü_Enum         => EndeMenü (MenueDatentypen.Spielstand_Menü_Enum)
                                                );

end SystemKonstanten;
