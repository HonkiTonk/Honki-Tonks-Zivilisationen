pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Characters.Wide_Wide_Latin_1; use Ada.Characters.Wide_Wide_Latin_1;

with GlobaleTexte;
with GlobaleVariablen;
with GrafikTonDatentypen;

with Eingabe;
with TextAnzeigeKonsole;

package body Informationen is

   procedure Informationen
   is begin

      -- Genau wie Würdigungen muss das hier eh geändert werden um mit den seperaten Tasks zu funktionieren!
      case
        GlobaleVariablen.AnzeigeArt
      is
         when GrafikTonDatentypen.Grafik_Konsole_Enum =>
            InformationenKonsole;
            
         when GrafikTonDatentypen.Grafik_SFML_Enum =>
            InformationenSFML;
      end case;
      
   end Informationen;
   
   
   
   procedure InformationenKonsole
   is begin
      
      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
      
      TextAnzeigeKonsole.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Allgemeine_Informationen,
                                                       TextZeileExtern => 1);      
      Put_Line (Item => Versionsnummer);

      TextAnzeigeKonsole.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                                TextDateiExtern        => GlobaleTexte.Allgemeine_Informationen,
                                                ÜberschriftZeileExtern => 0,
                                                ErsteZeileExtern       => 2,
                                                LetzteZeileExtern      => 12,
                                                AbstandAnfangExtern    => GlobaleTexte.Neue_Zeile,
                                                AbstandMitteExtern     => GlobaleTexte.Neue_Zeile,
                                                AbstandEndeExtern      => GlobaleTexte.Neue_Zeile);
      Eingabe.WartenEingabe;
      
   end InformationenKonsole;
   
   
   
   procedure InformationenSFML
   is begin
      
      null;
      
   end InformationenSFML;

end Informationen;
