pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Characters.Wide_Wide_Latin_1; use Ada.Characters.Wide_Wide_Latin_1;

with EinheitenDatentypen; use EinheitenDatentypen;
with KartenVerbesserungDatentypen; use KartenVerbesserungDatentypen;

with EingeleseneGrafikenTerminal;

package body FarbgebungTerminal is

   procedure Farben
     (EinheitIDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert;
      VerbesserungExtern : in KartenVerbesserungDatentypen.Karten_Verbesserung_Enum;
      WegExtern : in KartenVerbesserungDatentypen.Karten_Weg_Enum;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Enum;
      FlussExtern : in KartengrundDatentypen.Kartenfluss_Enum;
      RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Enum;
      CursorExtern : in Boolean;
      EigeneRasseExtern : in RassenDatentypen.Rassen_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Enum)
   is begin
            
      FarbenFeld (GrundExtern => GrundExtern);
      
      case
        FlussExtern
      is
         when KartengrundDatentypen.Leer_Fluss_Enum =>
            null;
            
         when others =>
            FarbenFluss (GrundExtern => GrundExtern,
                         FlussExtern => FlussExtern);
      end case;
      
      case
        RessourceExtern
      is
         when KartengrundDatentypen.Leer_Ressource_Enum =>
            null;
            
         when others =>
            FarbenRessourcen (GrundExtern     => GrundExtern,
                              RessourceExtern => RessourceExtern);
      end case;
      
      FarbenCursorEinheitVerbesserung (EinheitIDExtern    => EinheitIDExtern,
                                       VerbesserungExtern => VerbesserungExtern,
                                       WegExtern          => WegExtern,
                                       GrundExtern        => GrundExtern,
                                       FlussExtern        => FlussExtern,
                                       RessourceExtern    => RessourceExtern,
                                       CursorExtern       => CursorExtern,
                                       EigeneRasseExtern  => EigeneRasseExtern,
                                       RasseExtern        => RasseExtern);
      
   end Farben;
   
   
   
   procedure FarbenFeld
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum)
   is begin
      
      Put (Item => CSI & Feldfarbe (GrundExtern));
      
   end FarbenFeld;
   
   
   
   procedure FarbenFluss
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum;
      FlussExtern : in KartengrundDatentypen.Kartenfluss_Vorhanden_Enum)
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Eis_Enum | KartengrundDatentypen.Tundra_Enum | KartengrundDatentypen.Wüste_Enum | KartengrundDatentypen.Sand_Enum | KartengrundDatentypen.Küstengewässer_Enum
            | KartengrundDatentypen.Wolken_Enum | KartengrundDatentypen.Untereis_Enum | KartengrundDatentypen.Küstengrund_Enum =>
            if
              FlussExtern in KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Range
              or
                FlussExtern in KartengrundDatentypen.Kartenfluss_Unterfläche_Enum'Range
            then
               Put (Item => CSI & "38;2;0;0;205m");
               
            else
               -- Lavafluss
               Put (Item => CSI & "38;2;230;50;50m");
            end if;
                  
         when others =>
            if
              FlussExtern in KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Range
              or
                FlussExtern in KartengrundDatentypen.Kartenfluss_Unterfläche_Enum'Range
            then
               Put (Item => CSI & "38;2;135;206;250m");
               
            else
               -- Lavafluss
               Put (Item => CSI & "38;2;230;50;50m");
            end if;
      end case;
      
   end FarbenFluss;
   
   
   
   procedure FarbenRessourcen
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum;
      RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Vorhanden_Enum)
   is begin
      
      case
        RessourceExtern
      is
         when KartengrundDatentypen.Öl_Enum =>
            -- Eventuell mal verschiedene Farben für die einzelnen Ressourcen einbauen? äöü
            null;
            
         when others =>
            null;
      end case;
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Eis_Enum | KartengrundDatentypen.Tundra_Enum | KartengrundDatentypen.Wüste_Enum | KartengrundDatentypen.Sand_Enum | KartengrundDatentypen.Küstengewässer_Enum
            | KartengrundDatentypen.Wolken_Enum | KartengrundDatentypen.Untereis_Enum | KartengrundDatentypen.Küstengrund_Enum =>
            Put (Item => CSI & "38;2;0;0;0m");
                  
         when others =>
            Put (Item => CSI & "38;2;255;255;255m");
      end case;
      
   end FarbenRessourcen;
   
   
   
   procedure FarbenCursorEinheitVerbesserung
     (EinheitIDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert;
      VerbesserungExtern : in KartenVerbesserungDatentypen.Karten_Verbesserung_Enum;
      WegExtern : in KartenVerbesserungDatentypen.Karten_Weg_Enum;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Enum;
      FlussExtern : in KartengrundDatentypen.Kartenfluss_Enum;
      RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Enum;
      CursorExtern : in Boolean;
      EigeneRasseExtern : in RassenDatentypen.Rassen_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Enum)
   is begin
      
      if
        CursorExtern
      then
         Put (Item => CSI & "5m" & EingeleseneGrafikenTerminal.CursorGrafik (EigeneRasseExtern) & CSI & "0m");
         
      elsif
        EinheitIDExtern > EinheitenDatentypen.EinheitenIDMitNullWert'First
      then
         Put (Item => EingeleseneGrafikenTerminal.EinheitenGrafik (EigeneRasseExtern, EinheitIDExtern) & CSI & "0m");
        
      elsif
        VerbesserungExtern in KartenVerbesserungDatentypen.Karten_Verbesserung_Städte_Enum'Range
        and
          RasseExtern = EigeneRasseExtern
      then
         Put (Item => EingeleseneGrafikenTerminal.VerbesserungenGrafik (VerbesserungExtern) & CSI & "0m");
            
      elsif
        VerbesserungExtern in KartenVerbesserungDatentypen.Karten_Verbesserung_Städte_Enum'Range
      then
         case
           VerbesserungExtern
         is
            when KartenVerbesserungDatentypen.Hauptstadt_Enum =>
               Put (Item => EingeleseneGrafikenTerminal.VerbesserungenGrafik (KartenVerbesserungDatentypen.Hauptstadt_Enum) & CSI & "0m");
               
            when KartenVerbesserungDatentypen.Stadt_Enum =>
               Put (Item => EingeleseneGrafikenTerminal.VerbesserungenGrafik (KartenVerbesserungDatentypen.Stadt_Enum) & CSI & "0m");
               
            when others =>
               null;
         end case;
            
      elsif
        VerbesserungExtern /= KartenVerbesserungDatentypen.Leer_Verbesserung_Enum
      then
         Put (Item => EingeleseneGrafikenTerminal.VerbesserungenGrafik (VerbesserungExtern) & CSI & "0m");
            
      elsif
        WegExtern /= KartenVerbesserungDatentypen.Leer_Weg_Enum
      then
         Put (Item => EingeleseneGrafikenTerminal.WegeGrafik (WegExtern) & CSI & "0m");

      elsif
        RessourceExtern /= KartengrundDatentypen.Leer_Ressource_Enum
      then
         Put (Item => EingeleseneGrafikenTerminal.KartenressourcenGrafik (RessourceExtern) & CSI & "0m");
         
      elsif
        FlussExtern /= KartengrundDatentypen.Leer_Fluss_Enum
      then
         Put (Item => EingeleseneGrafikenTerminal.KartenflussGrafik (FlussExtern) & CSI & "0m");
            
      else
         Put (Item => EingeleseneGrafikenTerminal.KartenfelderGrafik (GrundExtern) & CSI & "0m");
      end if;
      
   end FarbenCursorEinheitVerbesserung;

end FarbgebungTerminal;
