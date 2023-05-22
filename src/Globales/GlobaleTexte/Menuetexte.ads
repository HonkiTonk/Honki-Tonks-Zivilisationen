with MenueKonstanten;
with TextKonstanten;
with MenueDatentypen;
with TextArrays;

package Menuetexte is
   pragma Elaborate_Body;
   
   -- Einfache Menüs.
   -- Ohne Überschrift.
   Hauptmenü : TextArrays.TexteArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Haupt_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Spielmenü : TextArrays.TexteArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Spiel_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
                               
   -- Mit Überschrift.
   Optionsmenü : TextArrays.TexteArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Optionen_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Einstellungsmenü : TextArrays.TexteArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Einstellungen_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Editoren : TextArrays.TexteArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Editoren_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Sonstigesmenü : TextArrays.TexteArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Sonstiges_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Debugmenü : TextArrays.TexteArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Debug_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Grafikmenü : TextArrays.TexteArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Grafik_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Kartengröße : TextArrays.TexteArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Kartengröße_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Kartenart : TextArrays.TexteArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Kartenart_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Kartentemperatur : TextArrays.TexteArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Kartentemperatur_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Schwierigkeitsgrad : TextArrays.TexteArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Schwierigkeitsgrad_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Ressourcenmenge : TextArrays.TexteArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Kartenressourcen_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Diplomatiemenü : TextArrays.TexteArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Diplomatie_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Kartenpole : TextArrays.TexteArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Kartenpole_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Soundmenü : TextArrays.TexteArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Sound_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
                               
   -- Doppelte Menüs.
   Speziesauswahl : TextArrays.TexteArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Spezies_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Kartenform : TextArrays.TexteArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Kartenform_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   
   -- Steuerungsmenü.
   Steuerungmenü : TextArrays.TexteArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Steuerung_Menü_Enum)) := (others => TextKonstanten.FehlenderText);

   -- SpeichernLadenmenü
   Spielstandmenü : TextArrays.TexteArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Spielstand_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   
end Menuetexte;
