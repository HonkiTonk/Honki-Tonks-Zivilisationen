with ArraysHTSEB;

with MenueKonstanten;
with TextKonstanten;
with MenueDatentypen;

package Menuetexte is
   pragma Elaborate_Body;
   
   -- Einfache Menüs.
   -- Ohne Überschrift.
   Hauptmenü : ArraysHTSEB.AllgemeinesTextArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Haupt_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Spielmenü : ArraysHTSEB.AllgemeinesTextArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Spiel_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
                               
   -- Mit Überschrift.
   Optionsmenü : ArraysHTSEB.AllgemeinesTextArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Optionen_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Einstellungsmenü : ArraysHTSEB.AllgemeinesTextArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Einstellungen_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Editorenmenü : ArraysHTSEB.AllgemeinesTextArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Editoren_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Spieleinstellungsmenü : ArraysHTSEB.AllgemeinesTextArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Spieleinstellungen_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Debugmenü : ArraysHTSEB.AllgemeinesTextArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Debug_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Grafikmenü : ArraysHTSEB.AllgemeinesTextArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Grafik_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Kartengröße : ArraysHTSEB.AllgemeinesTextArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Kartengröße_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Kartenart : ArraysHTSEB.AllgemeinesTextArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Kartenart_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Kartentemperatur : ArraysHTSEB.AllgemeinesTextArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Kartentemperatur_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Schwierigkeitsgrad : ArraysHTSEB.AllgemeinesTextArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Schwierigkeitsgrad_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Ressourcenmenge : ArraysHTSEB.AllgemeinesTextArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Kartenressourcen_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Diplomatiemenü : ArraysHTSEB.AllgemeinesTextArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Diplomatie_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Kartenpole : ArraysHTSEB.AllgemeinesTextArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Kartenpole_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Soundmenü : ArraysHTSEB.AllgemeinesTextArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Sound_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Handelsmenü : ArraysHTSEB.AllgemeinesTextArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Handel_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
                               
   -- Doppelte Menüs.
   Speziesauswahl : ArraysHTSEB.AllgemeinesTextArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Spezies_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Kartenform : ArraysHTSEB.AllgemeinesTextArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Kartenform_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   
   -- Steuerungsmenü.
   Steuerungsmenü : ArraysHTSEB.AllgemeinesTextArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Steuerung_Menü_Enum)) := (others => TextKonstanten.FehlenderText);

   -- SpeichernLadenmenü
   Spielstandmenü : ArraysHTSEB.AllgemeinesTextArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Spielstand_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   
end Menuetexte;
