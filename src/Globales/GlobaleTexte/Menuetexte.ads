with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with MenueKonstanten;
with TextKonstanten;
with MenueDatentypen;

package Menuetexte is
   pragma Elaborate_Body;
   
   type TexteArray is array (Positive range <>) of Unbounded_Wide_Wide_String;
   
   -- Einfache Menüs.
   -- Ohne Überschrift.
   Hauptmenü : TexteArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Haupt_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Spielmenü : TexteArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Spiel_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
                               
   -- Mit Überschrift.
   Optionsmenü : TexteArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Optionen_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Einstellungsmenü : TexteArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Einstellungen_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Editoren : TexteArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Editoren_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Sonstigesmenü : TexteArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Sonstiges_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Debugmenü : TexteArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Debug_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Grafikmenü : TexteArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Grafik_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Kartengröße : TexteArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Kartengröße_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Kartenart : TexteArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Kartenart_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Kartentemperatur : TexteArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Kartentemperatur_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Schwierigkeitsgrad : TexteArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Schwierigkeitsgrad_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Ressourcenmenge : TexteArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Kartenressourcen_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Diplomatiemenü : TexteArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Diplomatie_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Kartenpole : TexteArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Kartenpole_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Soundmenü : TexteArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Sound_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
                               
   -- Doppelte Menüs.
   Speziesauswahl : TexteArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Spezies_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   Kartenform : TexteArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Kartenform_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   
   -- Steuerungsmenü.
   Steuerungmenü : TexteArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Steuerung_Menü_Enum)) := (others => TextKonstanten.FehlenderText);

   -- SpeichernLadenmenü
   Spielstandmenü : TexteArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Spielstand_Menü_Enum)) := (others => TextKonstanten.FehlenderText);
   
end Menuetexte;
