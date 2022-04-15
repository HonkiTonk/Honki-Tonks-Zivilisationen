pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package SystemDatentypen is

   -- Wichtige Werte
   --------------------------Auch in die RueckgabeDatentypen verschieben und zu MenueDatentypen machen? Oder in eigene Datentypen?
   type Welches_Menü_Enum is (
                               Leer_Menü_Enum,
                               
                               -- Einfache Auswahl, keine Überschrift und kein Zusatztext.
                               Haupt_Menü_Enum, Spiel_Menü_Enum,
                               
                               -- Einfache Auswahl und kein Zusatztext.
                               Optionen_Menü_Enum, Einstellungen_Menü_Enum, Editoren_Menü_Enum,
                               
                               -- Einfache Auswahl.
                               Sonstiges_Menü_Enum,
                               Kartengröße_Menü_Enum, Kartenart_Menü_Enum, Kartentemperatur_Menü_Enum, Kartenressourcen_Menü_Enum, Schwierigkeitsgrad_Menü_Enum, Rassen_Menü_Enum,
                                
                               -- Komplexe Auswahl.
                               Kartenform_Menü_Enum, Grafik_Menü_Enum, Sound_Menü_Enum, Steuerung_Menü_Enum
                              );
   
   subtype Welches_Menü_Vorhanden_Enum is Welches_Menü_Enum range Haupt_Menü_Enum .. Welches_Menü_Enum'Last;
   
   subtype Menü_Einfach_Enum is Welches_Menü_Vorhanden_Enum range Haupt_Menü_Enum .. Rassen_Menü_Enum;
   subtype Menü_Ohne_Überschrift_Enum is Menü_Einfach_Enum range Haupt_Menü_Enum .. Spiel_Menü_Enum;
   subtype Menü_Mit_Überschrift_Enum is Menü_Einfach_Enum range Optionen_Menü_Enum .. Editoren_Menü_Enum;
   subtype Menü_Zusatztext_Enum is Welches_Menü_Enum range Sonstiges_Menü_Enum .. Rassen_Menü_Enum;
   
   subtype Menü_Komplex_Enum is Welches_Menü_Enum range Kartenform_Menü_Enum .. Steuerung_Menü_Enum;
   
   type Anfang_Ende_Enum is (
                             Anfangswert_Enum, Endwert_Enum
                            );
   
   type Welche_Eingabe_Enum is (
                                Keine_Eingabe_Enum,
                                
                                Zahlen_Eingabe_Enum, Text_Eingabe_Enum, Einheit_Auswahl_Enum
                               );
   -- Wichtige Werte
   
    
   
   -- Sonstiges
   subtype Grenzen is Integer range -1_000_000_000 .. 1_000_000_000;

   type Staatsform_Enum is (
                            Anarchie_Enum,
                            Demokratie_Enum
                           );

   type StaatsformenArray is array (1 .. 5) of Staatsform_Enum;
   -- Sonstiges



   -- Für Diplomatie
   type Status_Untereinander_Enum is (
                                      Unbekannt_Enum, Neutral_Enum, Nichtangriffspakt_Enum, Krieg_Enum
                                     );
   subtype Status_Untereinander_Bekannt_Enum is Status_Untereinander_Enum range Neutral_Enum .. Status_Untereinander_Enum'Last;
   -- Für Diplomatie

end SystemDatentypen;
