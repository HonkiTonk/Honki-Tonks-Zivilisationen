package RueckgabeDatentypen is
   pragma Pure;
   
   type Rückgabe_Werte_Enum is (
                                 Leer_Auswahl_Enum,
                                 
                                 Start_Weiter_Standard_Enum,
                                 
                                 Auswahl_Eins_Enum, Auswahl_Zwei_Enum, Auswahl_Drei_Enum, Auswahl_Vier_Enum, Auswahl_Fünf_Enum, Auswahl_Sechs_Enum, Auswahl_Sieben_Enum, Auswahl_Acht_Enum, Auswahl_Neun_Enum,
                                 Auswahl_Zehn_Enum, Auswahl_Elf_Enum, Auswahl_Zwölf_Enum, Auswahl_Dreizehn_Enum, Auswahl_Vierzehn_Enum, Auswahl_Fünfzehn_Enum, Auswahl_Sechzehn_Enum, Auswahl_Siebzehn_Enum,
                                 Auswahl_Achtzehn_Enum,
                                 
                                 Auswahl_Neunzehn_Enum,
                                 
                                 Fertig_Enum, Zurück_Enum, Hauptmenü_Enum, Spiel_Beenden_Enum
                                );
   pragma Ordered (Rückgabe_Werte_Enum);
      
   -- Aktuell die maximale Länge ohne Zusatzauswahlen, wird bei der Speziesauswahl verwendet.
   subtype Auswahl_Enum is Rückgabe_Werte_Enum range Auswahl_Eins_Enum .. Auswahl_Achtzehn_Enum;
   
   -- Diese subtypen für alle Menüs einbauen. äöü
   subtype Kartengrößen_Standard_Enum is Auswahl_Enum range Auswahl_Eins_Enum .. Auswahl_Zehn_Enum;
   subtype Kartenebenen_Enum is Auswahl_Enum range Auswahl_Eins_Enum .. Auswahl_Fünf_Enum;
   subtype Kartenart_Enum is Auswahl_Enum range Auswahl_Eins_Enum .. Auswahl_Drei_Enum;
   subtype Kartentemperatur_Enum is Auswahl_Enum range Auswahl_Eins_Enum .. Auswahl_Fünf_Enum;
   subtype Kartenrohstoffe_Enum is Auswahl_Enum range Auswahl_Eins_Enum .. Auswahl_Vier_Enum;
   subtype Kartenform_Enum is Auswahl_Enum range Auswahl_Eins_Enum .. Auswahl_Sechs_Enum;
   
   subtype Schwierigkeitsgrad_Enum is Auswahl_Enum range Auswahl_Eins_Enum .. Auswahl_Drei_Enum;
   
   subtype Spezies_Verwendet_Enum is Auswahl_Enum range Auswahl_Eins_Enum .. Auswahl_Achtzehn_Enum;
   
   subtype Zurück_Beenden_Enum is Rückgabe_Werte_Enum range Zurück_Enum .. Spiel_Beenden_Enum;
   subtype Hauptmenü_Beenden_Enum is Zurück_Beenden_Enum range Hauptmenü_Enum .. Spiel_Beenden_Enum;

end RueckgabeDatentypen;
