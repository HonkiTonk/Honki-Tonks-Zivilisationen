with MenueDatentypen;

-- Das hier mal aufteilen und anders benennen, ist ja hauptsächlich Menüzeug. äöü
package MenueKonstanten is
   pragma Elaborate_Body;

   SchleifenwertanpassungGrafikZuAuswahlPosition : constant Positive := 1;
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
                                           MenueDatentypen.Grafik_Menü_Enum             => 9,
                                           MenueDatentypen.Sound_Menü_Enum              => 6,
                                           MenueDatentypen.Debug_Menü_Enum              => 6,
                                           MenueDatentypen.Kartenart_Menü_Enum          => 9,
                                           MenueDatentypen.Kartentemperatur_Menü_Enum   => 8,
                                           MenueDatentypen.Kartenressourcen_Menü_Enum   => 8,
                                           MenueDatentypen.Schwierigkeitsgrad_Menü_Enum => 6,
                                           MenueDatentypen.Kartengröße_Menü_Enum        => 16,
                                           MenueDatentypen.Diplomatie_Menü_Enum         => 10,
                                           MenueDatentypen.Kartenpole_Menü_Enum         => 8,

                                           -- Doppelte Menüs.
                                           MenueDatentypen.Spezies_Menü_Enum            => 21,
                                           MenueDatentypen.Kartenform_Menü_Enum         => 14,

                                           -- Steuerungsmenü.
                                           MenueDatentypen.Steuerung_Menü_Enum          => 63,

                                           -- Spielstandmenü
                                           MenueDatentypen.Spielstand_Menü_Enum         => 15
                                          );

   -- Theoretich kann man hier noch -1 machen um die Überschrift abzuziehen, wird in den Positionen/Textaccessen nicht mehr benötigt. äöü
   -- Braucht aber diverse Anpassungen, später mal anschauen. äöü
   ZweitlängstesMenü : constant Positive := EndeMenü (MenueDatentypen.Spezies_Menü_Enum);
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
                                                 MenueDatentypen.Spezies_Menü_Enum             => EndeMenü (MenueDatentypen.Spezies_Menü_Enum),
                                                 MenueDatentypen.Kartenform_Menü_Enum         => EndeMenü (MenueDatentypen.Kartenform_Menü_Enum) - 4,

                                                 -- Steuerungsmenü.
                                                 MenueDatentypen.Steuerung_Menü_Enum          => EndeMenü (MenueDatentypen.Steuerung_Menü_Enum),

                                                 -- Spielstandmenü.
                                                 MenueDatentypen.Spielstand_Menü_Enum         => EndeMenü (MenueDatentypen.Spielstand_Menü_Enum)
                                                );

   -- Steuerung
   -- Diese Werte (teilweise? vollständig?) nach TastenbelegungDatentypen und BefehleDatentypen verschieben? äöü
   AllgemeineSteuerung : constant Positive := 2;
   AllgemeineSteuerungEnumausgleich : constant Positive := AllgemeineSteuerung - 1;
   Einheitensteuerung : constant Positive := 25;
   EinheitensteuerungEnumausgleich : constant Positive := Einheitensteuerung - 1;
   Stadtsteuerung : constant Positive := 52;
   StadtsteuerungEnumausgleich : constant Positive := Stadtsteuerung - 1;
   SonstigesSteuerung : constant Positive := 59;
   -- Steuerung

end MenueKonstanten;
