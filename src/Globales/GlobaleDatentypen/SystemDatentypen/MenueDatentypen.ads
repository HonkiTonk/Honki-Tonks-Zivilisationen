package MenueDatentypen is
   pragma Pure;

   type Welches_Menü_Enum is (
                               Leer_Menü_Enum,
                               
                               -- Einfache Menüs.
                               -- Ohne Überschrift.
                               Haupt_Menü_Enum, Spiel_Menü_Enum,
                               
                               -- Mit Überschrift.
                               Optionen_Menü_Enum, Grafik_Menü_Enum, Sound_Menü_Enum, Einstellungen_Menü_Enum, Editoren_Menü_Enum, Sonstiges_Menü_Enum, Debug_Menü_Enum,
                               Kartenart_Menü_Enum, Kartenressourcen_Menü_Enum, Schwierigkeitsgrad_Menü_Enum, Kartentemperatur_Menü_Enum, Kartengröße_Menü_Enum, Diplomatie_Menü_Enum, Kartenpole_Menü_Enum,
                               
                               -- Doppelte Menüs.
                               Spezies_Menü_Enum, Kartenform_Menü_Enum,
                               
                               -- Steuerungsmneü.
                               Steuerung_Menü_Enum,
                               
                               -- SpeicherLaden.
                               Spielstand_Menü_Enum
                              );
   
   subtype Welches_Menü_Vorhanden_Enum is Welches_Menü_Enum range Welches_Menü_Enum'Succ (Welches_Menü_Enum'First) .. Welches_Menü_Enum'Last;
   subtype Menü_Ohne_Steuerung_Enum is Welches_Menü_Vorhanden_Enum range Welches_Menü_Vorhanden_Enum'First .. Kartenform_Menü_Enum;
   
   subtype Menü_Einfach_Enum is Menü_Ohne_Steuerung_Enum range Haupt_Menü_Enum .. Kartenpole_Menü_Enum;
   subtype Menü_Zusatztext_Einfach_Enum is Menü_Einfach_Enum range Kartengröße_Menü_Enum .. Kartenpole_Menü_Enum;
   subtype Menü_Doppelt_Enum is Menü_Ohne_Steuerung_Enum range Spezies_Menü_Enum .. Kartenform_Menü_Enum;
   subtype Menü_Steuerung_Enum is Welches_Menü_Vorhanden_Enum range Steuerung_Menü_Enum .. Steuerung_Menü_Enum;
   
   subtype Menü_Ohne_Überschrift_Enum is Menü_Einfach_Enum range Haupt_Menü_Enum .. Spiel_Menü_Enum;
   
end MenueDatentypen;
