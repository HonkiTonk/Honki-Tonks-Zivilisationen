pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Characters.Wide_Wide_Latin_9; use Ada.Characters.Wide_Wide_Latin_9;

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with KartenDatentypen; use KartenDatentypen;

with LeseEinheitenDatenbank;
with LeseVerbesserungenDatenbank;
with LeseKartenDatenbank;

package body Farbgebung is

   procedure Farben
     (EinheitIDExtern : in EinheitStadtDatentypen.EinheitenIDMitNullWert;
      VerbesserungExtern : in KartenDatentypen.Karten_Verbesserung_Enum;
      RessourceExtern : in KartenDatentypen.Karten_Grund_Enum;
      GrundExtern : in KartenDatentypen.Karten_Grund_Enum;
      CursorExtern : in Boolean;
      EigeneRasseExtern : in SonstigeDatentypen.Rassen_Enum;
      RasseExtern : in SonstigeDatentypen.Rassen_Enum)
   is begin
            
      FarbenFeld (GrundExtern => GrundExtern);
      
      FarbenRessourcenFluss (GrundExtern     => GrundExtern,
                             RessourceExtern => RessourceExtern);
      
      FarbenCursorEinheitVerbesserung (EinheitIDExtern    => EinheitIDExtern,
                                       VerbesserungExtern => VerbesserungExtern,
                                       RessourceExtern    => RessourceExtern,
                                       GrundExtern        => GrundExtern,
                                       CursorExtern       => CursorExtern,
                                       EigeneRasseExtern  => EigeneRasseExtern,
                                       RasseExtern        => RasseExtern);
      
   end Farben;
   
   
   
   procedure FarbenFeld
     (GrundExtern : in KartenDatentypen.Karten_Grund_Enum)
   is begin
      
      case
        GrundExtern
      is
         when KartenDatentypen.Eis | KartenDatentypen.Unterwasser_Eis =>
            Put (Item => CSI & "48;2;255;245;238m");
            
         when KartenDatentypen.Wasser | KartenDatentypen.Unterwasser_Wasser =>
            Put (Item => CSI & "48;2;0;0;205m");
            
         when KartenDatentypen.Flachland =>
            Put (Item => CSI & "48;2;100;160;60m");
            
         when KartenDatentypen.Tundra =>
            Put (Item => CSI & "48;2;205;200;177m");
            
         when KartenDatentypen.Wüste | KartenDatentypen.Sand =>
            Put (Item => CSI & "48;2;238;238;0m");
            
         when KartenDatentypen.Hügel =>
            Put (Item => CSI & "48;2;205;133;63m");
            
         when KartenDatentypen.Gebirge =>
            Put (Item => CSI & "48;2;120;120;120m");
            
         when KartenDatentypen.Wald =>
            Put (Item => CSI & "48;2;30;130;30m");
            
         when KartenDatentypen.Dschungel =>
            Put (Item => CSI & "48;2;0;70;0m");
            
         when KartenDatentypen.Küstengewässer | KartenDatentypen.Unterwasser_Küstengewässer =>
            Put (Item => CSI & "48;2;135;206;250m");
            
         when KartenDatentypen.Sumpf =>
            Put (Item => CSI & "48;2;0;40;0m");

         when KartenDatentypen.Erde =>
            Put (Item => CSI & "48;2;139;69;19m");
            
         when KartenDatentypen.Erdgestein =>
            Put (Item => CSI & "48;2;120;120;120m");
            
         when KartenDatentypen.Lava =>
            Put (Item => CSI & "48;2;250;39;39m");
            
         when KartenDatentypen.Wolken =>
            Put (Item => CSI & "48;2;236;236;236m");
            
         when KartenDatentypen.Weltraum =>
            Put (Item => CSI & "48;2;127;127;127m");
            
         when KartenDatentypen.Gestein =>
            Put (Item => CSI & "48;2;87;87;87m");   
            
         when KartenDatentypen.Planetenkern =>
            Put (Item => CSI & "48;2;205;0;0m");
            
         when KartenDatentypen.Unterwasser_Wald =>
            Put (Item => CSI & "48;2;127;255;212m");
            
         when KartenDatentypen.Korallen =>
            Put (Item => CSI & "48;2;255;114;86m");
            
         when others =>
            null;
      end case;
      
   end FarbenFeld;
   
   
   
   procedure FarbenRessourcenFluss
     (GrundExtern : in KartenDatentypen.Karten_Grund_Enum;
      RessourceExtern : in KartenDatentypen.Karten_Grund_Enum)
   is begin
      
      case
        GrundExtern
      is
         when KartenDatentypen.Eis | KartenDatentypen.Tundra | KartenDatentypen.Wüste | KartenDatentypen.Sand | KartenDatentypen.Küstengewässer | KartenDatentypen.Wolken | KartenDatentypen.Unterwasser_Eis
            | KartenDatentypen.Unterwasser_Küstengewässer =>
            if
              RessourceExtern in KartenDatentypen.Karten_Grund_Fluss_Enum'Range
              or
                RessourceExtern in KartenDatentypen.Karten_Grund_Unterirdischer_Fluss_Enum'Range
            then
               Put (Item => CSI & "38;2;0;0;205m");
               
            elsif
              RessourceExtern in KartenDatentypen.Karten_Grund_Lavafluss_Enum'Range
            then
               Put (Item => CSI & "38;2;230;50;50m");
               
            else
               Put (Item => CSI & "38;2;0;0;0m");
            end if;
                  
         when others =>
            if
              RessourceExtern in KartenDatentypen.Karten_Grund_Fluss_Enum'Range
              or
                RessourceExtern in KartenDatentypen.Karten_Grund_Unterirdischer_Fluss_Enum'Range
            then
               Put (Item => CSI & "38;2;135;206;250m");
               
            elsif
              RessourceExtern in KartenDatentypen.Karten_Grund_Lavafluss_Enum'Range
            then
               Put (Item => CSI & "38;2;230;50;50m");
               
            else
               Put (Item => CSI & "38;2;255;255;255m");
            end if;
      end case;
      
   end FarbenRessourcenFluss;
   
   
   
   procedure FarbenCursorEinheitVerbesserung
     (EinheitIDExtern : in EinheitStadtDatentypen.EinheitenIDMitNullWert;
      VerbesserungExtern : in KartenDatentypen.Karten_Verbesserung_Enum;
      RessourceExtern : in KartenDatentypen.Karten_Grund_Enum;
      GrundExtern : in KartenDatentypen.Karten_Grund_Enum;
      CursorExtern : in Boolean;
      EigeneRasseExtern : in SonstigeDatentypen.Rassen_Enum;
      RasseExtern : in SonstigeDatentypen.Rassen_Enum)
   is begin
      
      if
        CursorExtern
      then
         Put (Item => CSI & "5m" & GlobaleVariablen.CursorImSpiel (EigeneRasseExtern).CursorGrafik & CSI & "0m");
         
      elsif
        EinheitIDExtern > EinheitStadtDatentypen.EinheitenIDMitNullWert'First
      then
         Put (Item => LeseEinheitenDatenbank.EinheitenGrafik (RasseExtern => EigeneRasseExtern,
                                                              IDExtern    => EinheitIDExtern) & CSI & "0m");
        
      elsif
        VerbesserungExtern in KartenDatentypen.Karten_Verbesserung_Eigene_Städte_Enum'Range
        and
          RasseExtern = EigeneRasseExtern
      then
         Put (Item => LeseVerbesserungenDatenbank.VerbesserungGrafik (VerbesserungExtern => VerbesserungExtern) & CSI & "0m");
            
      elsif
        VerbesserungExtern in KartenDatentypen.Karten_Verbesserung_Eigene_Städte_Enum'Range
      then
         case
           VerbesserungExtern
         is
            when KartenDatentypen.Eigene_Hauptstadt =>
               Put (Item => LeseVerbesserungenDatenbank.VerbesserungGrafik (VerbesserungExtern => KartenDatentypen.Fremde_Hauptstadt) & CSI & "0m");
               
            when KartenDatentypen.Eigene_Stadt =>
               Put (Item => LeseVerbesserungenDatenbank.VerbesserungGrafik (VerbesserungExtern => KartenDatentypen.Fremde_Stadt) & CSI & "0m");
               
            when others =>
               null;
         end case;
            
      elsif
        VerbesserungExtern /= KartenDatentypen.Leer
      then
         Put (Item => LeseVerbesserungenDatenbank.VerbesserungGrafik (VerbesserungExtern => VerbesserungExtern) & CSI & "0m");

      elsif
        RessourceExtern /= KartenDatentypen.Leer
      then
         Put (Item => LeseKartenDatenbank.KartenGrafik (GrundExtern => RessourceExtern) & CSI & "0m");
            
      else
         Put (Item => LeseKartenDatenbank.KartenGrafik (GrundExtern => GrundExtern) & CSI & "0m");
      end if;
      
   end FarbenCursorEinheitVerbesserung;

end Farbgebung;
