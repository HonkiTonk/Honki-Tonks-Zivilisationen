pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package MenueDatentypen is

   type Welches_Menü_Enum is (
                               Leer_Menü_Enum,
                               
                               -- Einfache Auswahl, keine Überschrift und kein Zusatztext.
                               Haupt_Menü_Enum, Spiel_Menü_Enum,
                               
                               -- Einfache Auswahl und kein Zusatztext.
                               Optionen_Menü_Enum, Grafik_Menü_Enum, Sound_Menü_Enum, Einstellungen_Menü_Enum, Editoren_Menü_Enum, Sonstiges_Menü_Enum,
                               Kartenart_Menü_Enum, Kartenressourcen_Menü_Enum, Schwierigkeitsgrad_Menü_Enum, Kartentemperatur_Menü_Enum,
                               
                               -- Einfache Auswahl.
                               Kartengröße_Menü_Enum, Kartenform_Menü_Enum, Rassen_Menü_Enum,
                                
                               -- Komplexe Auswahl.
                               
                               -- Unsortiert.
                               Steuerung_Menü_Enum
                              );
   
   subtype Welches_Menü_Vorhanden_Enum is Welches_Menü_Enum range Haupt_Menü_Enum .. Welches_Menü_Enum'Last;
   
   subtype Menü_Einfach_Enum is Welches_Menü_Vorhanden_Enum range Haupt_Menü_Enum .. Rassen_Menü_Enum;
   
   subtype Menü_Ohne_Überschrift_Enum is Menü_Einfach_Enum range Haupt_Menü_Enum .. Spiel_Menü_Enum;
   
   subtype Menü_Mit_Überschrift_Enum is Menü_Einfach_Enum range Optionen_Menü_Enum .. Kartentemperatur_Menü_Enum;
   subtype Menü_Einstellung_Anzeigen_Enum is Menü_Einfach_Enum range Kartenart_Menü_Enum .. Rassen_Menü_Enum;
   
   subtype Menü_Zusatztext_Enum is Menü_Einfach_Enum range Kartengröße_Menü_Enum .. Rassen_Menü_Enum;
   
   subtype Menü_Komplex_Enum is Welches_Menü_Enum range Steuerung_Menü_Enum .. Steuerung_Menü_Enum;

end MenueDatentypen;
