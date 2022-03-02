pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Characters.Wide_Wide_Latin_1; use Ada.Characters.Wide_Wide_Latin_1;

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with KartenVerbesserungKonstanten;

with LeseEinheitenDatenbank;
with LeseVerbesserungenDatenbank;
with LeseKartenDatenbank;

package body FarbgebungKonsole is

   procedure Farben
     (EinheitIDExtern : in EinheitStadtDatentypen.EinheitenIDMitNullWert;
      VerbesserungExtern : in KartenDatentypen.Karten_Verbesserung_Enum;
      RessourceExtern : in KartenDatentypen.Karten_Grund_Enum;
      GrundExtern : in KartenDatentypen.Karten_Grund_Enum;
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
     (GrundExtern : in KartenDatentypen.Karten_Grund_Alle_Felder_Enum)
   is begin
      
      Put (Item => CSI & Feldfarbe (GrundExtern));
      
   end FarbenFeld;
   
   
   
   procedure FarbenRessourcenFluss
     (GrundExtern : in KartenDatentypen.Karten_Grund_Enum;
      RessourceExtern : in KartenDatentypen.Karten_Grund_Enum)
   is begin
      
      case
        GrundExtern
      is
         when KartenGrundKonstanten.EisKonstante | KartenGrundKonstanten.TundraKonstante | KartenGrundKonstanten.WüsteKonstante | KartenGrundKonstanten.SandKonstante | KartenGrundKonstanten.KüstengewässerKonstante
            | KartenGrundKonstanten.WolkenKonstante | KartenGrundKonstanten.UnterwasserEisKonstante | KartenGrundKonstanten.UnterwasserKüstengewässerKonstante =>
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
      EigeneRasseExtern : in SystemDatentypen.Rassen_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Enum)
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
        VerbesserungExtern /= KartenVerbesserungKonstanten.LeerVerbesserung
      then
         Put (Item => LeseVerbesserungenDatenbank.VerbesserungGrafik (VerbesserungExtern => VerbesserungExtern) & CSI & "0m");

      elsif
        RessourceExtern /= KartenGrundKonstanten.LeerGrund
      then
         Put (Item => LeseKartenDatenbank.KartenGrafikKonsole (GrundExtern => RessourceExtern) & CSI & "0m");
            
      else
         Put (Item => LeseKartenDatenbank.KartenGrafikKonsole (GrundExtern => GrundExtern) & CSI & "0m");
      end if;
      
   end FarbenCursorEinheitVerbesserung;

end FarbgebungKonsole;
