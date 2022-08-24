pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package MenueDatentypen is

   type Welches_Menü_Enum is (
                               Leer_Menü_Enum,
                               
                               -- Einfache Menüs.
                               -- Ohne Überschrift.
                               Haupt_Menü_Enum, Spiel_Menü_Enum,
                               
                               -- Mit Überschrift.
                               Optionen_Menü_Enum, Grafik_Menü_Enum, Sound_Menü_Enum, Einstellungen_Menü_Enum, Editoren_Menü_Enum, Sonstiges_Menü_Enum, Debug_Menü_Enum,
                               Kartenart_Menü_Enum, Kartenressourcen_Menü_Enum, Schwierigkeitsgrad_Menü_Enum, Kartentemperatur_Menü_Enum, Kartengröße_Menü_Enum, Kartenpole_Menü_Enum,
                               
                               -- Doppelte Menüs.
                               Rassen_Menü_Enum, Kartenform_Menü_Enum,
                               
                               -- Steuerungsmneü.
                               Steuerung_Menü_Enum
                              );
   
   subtype Welches_Menü_Vorhanden_Enum is Welches_Menü_Enum range Haupt_Menü_Enum .. Welches_Menü_Enum'Last;
   
   subtype Menü_Einfach_Enum is Welches_Menü_Vorhanden_Enum range Haupt_Menü_Enum .. Kartenpole_Menü_Enum;
   subtype Menü_Doppelt_Enum is Welches_Menü_Vorhanden_Enum range Rassen_Menü_Enum .. Kartenform_Menü_Enum;
   subtype Menü_Steuerung_Enum is Welches_Menü_Vorhanden_Enum range Steuerung_Menü_Enum .. Steuerung_Menü_Enum;
   
   subtype Menü_Ohne_Überschrift_Enum is Menü_Einfach_Enum range Haupt_Menü_Enum .. Spiel_Menü_Enum;
   
   -- Müssten die nicht auch auflösbar/verschmelzbar sein?
   subtype Menü_Zusatztext_Enum is Welches_Menü_Vorhanden_Enum range Kartengröße_Menü_Enum .. Kartenform_Menü_Enum;
   subtype Menü_Zusatztext_Einfach_Enum is Menü_Zusatztext_Enum range Kartengröße_Menü_Enum .. Kartenpole_Menü_Enum;

end MenueDatentypen;
