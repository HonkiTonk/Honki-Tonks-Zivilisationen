pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Characters.Wide_Wide_Latin_1; use Ada.Characters.Wide_Wide_Latin_1;

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with KartenVerbesserungDatentypen; use KartenVerbesserungDatentypen;

with EingeleseneGrafikenKonsole;

package body FarbgebungKonsole is

   procedure Farben
     (EinheitIDExtern : in EinheitStadtDatentypen.EinheitenIDMitNullWert;
      VerbesserungExtern : in KartenVerbesserungDatentypen.Karten_Verbesserung_Enum;
      RessourceExtern : in KartenGrundDatentypen.Karten_Grund_Enum;
      GrundExtern : in KartenGrundDatentypen.Karten_Grund_Enum;
      CursorExtern : in Boolean;
      EigeneRasseExtern : in SystemDatentypen.Rassen_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Enum)
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
     (GrundExtern : in KartenGrundDatentypen.Karten_Grund_Alle_Felder_Enum)
   is begin
      
      Put (Item => CSI & Feldfarbe (GrundExtern));
      
   end FarbenFeld;
   
   
   
   procedure FarbenRessourcenFluss
     (GrundExtern : in KartenGrundDatentypen.Karten_Grund_Enum;
      RessourceExtern : in KartenGrundDatentypen.Karten_Grund_Enum)
   is begin
      
      case
        GrundExtern
      is
         when KartenGrundDatentypen.Eis_Enum | KartenGrundDatentypen.Tundra_Enum | KartenGrundDatentypen.Wüste_Enum | KartenGrundDatentypen.Sand_Enum | KartenGrundDatentypen.Küstengewässer_Enum
            | KartenGrundDatentypen.Wolken_Enum | KartenGrundDatentypen.Unterwasser_Eis_Enum | KartenGrundDatentypen.Unterwasser_Küstengewässer_Enum =>
            if
              RessourceExtern in KartenGrundDatentypen.Karten_Grund_Fluss_Enum'Range
              or
                RessourceExtern in KartenGrundDatentypen.Karten_Grund_Unterirdischer_Fluss_Enum'Range
            then
               Put (Item => CSI & "38;2;0;0;205m");
               
            elsif
              RessourceExtern in KartenGrundDatentypen.Karten_Grund_Lavafluss_Enum'Range
            then
               Put (Item => CSI & "38;2;230;50;50m");
               
            else
               Put (Item => CSI & "38;2;0;0;0m");
            end if;
                  
         when others =>
            if
              RessourceExtern in KartenGrundDatentypen.Karten_Grund_Fluss_Enum'Range
              or
                RessourceExtern in KartenGrundDatentypen.Karten_Grund_Unterirdischer_Fluss_Enum'Range
            then
               Put (Item => CSI & "38;2;135;206;250m");
               
            elsif
              RessourceExtern in KartenGrundDatentypen.Karten_Grund_Lavafluss_Enum'Range
            then
               Put (Item => CSI & "38;2;230;50;50m");
               
            else
               Put (Item => CSI & "38;2;255;255;255m");
            end if;
      end case;
      
   end FarbenRessourcenFluss;
   
   
   
   procedure FarbenCursorEinheitVerbesserung
     (EinheitIDExtern : in EinheitStadtDatentypen.EinheitenIDMitNullWert;
      VerbesserungExtern : in KartenVerbesserungDatentypen.Karten_Verbesserung_Enum;
      RessourceExtern : in KartenGrundDatentypen.Karten_Grund_Enum;
      GrundExtern : in KartenGrundDatentypen.Karten_Grund_Enum;
      CursorExtern : in Boolean;
      EigeneRasseExtern : in SystemDatentypen.Rassen_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Enum)
   is begin
      
      if
        CursorExtern
      then
         Put (Item => CSI & "5m" & EingeleseneGrafikenKonsole.CursorGrafik (EigeneRasseExtern) & CSI & "0m");
         
      elsif
        EinheitIDExtern > EinheitStadtDatentypen.EinheitenIDMitNullWert'First
      then
         Put (Item => EingeleseneGrafikenKonsole.EinheitenGrafik (EigeneRasseExtern, EinheitIDExtern) & CSI & "0m");
        
      elsif
        VerbesserungExtern in KartenVerbesserungDatentypen.Karten_Verbesserung_Eigene_Städte_Enum'Range
        and
          RasseExtern = EigeneRasseExtern
      then
         Put (Item => EingeleseneGrafikenKonsole.VerbesserungGrafik (VerbesserungExtern) & CSI & "0m");
            
      elsif
        VerbesserungExtern in KartenVerbesserungDatentypen.Karten_Verbesserung_Eigene_Städte_Enum'Range
      then
         case
           VerbesserungExtern
         is
            when KartenVerbesserungDatentypen.Eigene_Hauptstadt_Enum =>
               Put (Item => EingeleseneGrafikenKonsole.VerbesserungGrafik (KartenVerbesserungDatentypen.Fremde_Hauptstadt_Enum) & CSI & "0m");
               
            when KartenVerbesserungDatentypen.Eigene_Stadt_Enum =>
               Put (Item => EingeleseneGrafikenKonsole.VerbesserungGrafik (KartenVerbesserungDatentypen.Fremde_Stadt_Enum) & CSI & "0m");
               
            when others =>
               null;
         end case;
            
      elsif
        VerbesserungExtern /= KartenVerbesserungDatentypen.Leer_Verbesserung_Enum
      then
         Put (Item => EingeleseneGrafikenKonsole.VerbesserungGrafik (VerbesserungExtern) & CSI & "0m");

      elsif
        RessourceExtern /= KartenGrundDatentypen.Leer_Grund_Enum
      then
         Put (Item => EingeleseneGrafikenKonsole.KartenGrafik (RessourceExtern) & CSI & "0m");
            
      else
         Put (Item => EingeleseneGrafikenKonsole.KartenGrafik (GrundExtern) & CSI & "0m");
      end if;
      
   end FarbenCursorEinheitVerbesserung;

end FarbgebungKonsole;
