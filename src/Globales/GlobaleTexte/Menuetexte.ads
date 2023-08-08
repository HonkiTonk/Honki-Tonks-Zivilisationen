with MenueKonstanten;
with TextKonstanten;
with MenueDatentypen;
with TextArrays;

package Menuetexte is
   pragma Elaborate_Body;
   
   -- Einfache Menüs.
   -- Ohne Überschrift.
   Hauptmenü : TextArrays.AllgemeinesTextArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Haupt_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Spielmenü : TextArrays.AllgemeinesTextArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Spiel_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
                               
   -- Mit Überschrift.
   Optionsmenü : TextArrays.AllgemeinesTextArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Optionen_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Einstellungsmenü : TextArrays.AllgemeinesTextArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Einstellungen_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Editorenmenü : TextArrays.AllgemeinesTextArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Editoren_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Sonstigesmenü : TextArrays.AllgemeinesTextArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Sonstiges_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Debugmenü : TextArrays.AllgemeinesTextArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Debug_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Grafikmenü : TextArrays.AllgemeinesTextArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Grafik_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Kartengröße : TextArrays.AllgemeinesTextArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Kartengröße_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Kartenart : TextArrays.AllgemeinesTextArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Kartenart_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Kartentemperatur : TextArrays.AllgemeinesTextArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Kartentemperatur_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Schwierigkeitsgrad : TextArrays.AllgemeinesTextArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Schwierigkeitsgrad_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Ressourcenmenge : TextArrays.AllgemeinesTextArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Kartenressourcen_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Diplomatiemenü : TextArrays.AllgemeinesTextArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Diplomatie_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Kartenpole : TextArrays.AllgemeinesTextArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Kartenpole_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Soundmenü : TextArrays.AllgemeinesTextArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Sound_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
                               
   -- Doppelte Menüs.
   Speziesauswahl : TextArrays.AllgemeinesTextArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Spezies_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Kartenform : TextArrays.AllgemeinesTextArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Kartenform_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   
   -- Steuerungsmenü.
   Steuerungsmenü : TextArrays.AllgemeinesTextArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Steuerung_Menü_Enum)) := (others => TextKonstanten.FehlenderText);

   -- SpeichernLadenmenü
   Spielstandmenü : TextArrays.AllgemeinesTextArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Spielstand_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   
end Menuetexte;
