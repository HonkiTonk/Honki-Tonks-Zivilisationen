with KartenartDatentypen;
with KartenKonstanten;

with SchreibeWeltkarte;
with LeseWeltkarteneinstellungen;

with KartengeneratorVariablenLogik;

package body KartengeneratorPolregionLogik is

   procedure PolregionGenerieren
   is
      
      task Norden;
      task Süden;
      task Westen;
      task Osten;
      
      task body Norden
      is begin
         
         PolregionNorden;
         
      end Norden;
      
      
      
      task body Süden
      is begin
         
         PolregionSüden;
         
      end Süden;
      
      
      
      task body Westen
      is begin
         
         PolregionWesten;
         
      end Westen;
      
      
      
      task body Osten
      is begin
         
         PolregionOsten;
         
      end Osten;
   
   begin
      
      null;
      
   end PolregionGenerieren;
   
   
   
   procedure PolregionNorden
   is begin
      
      case
        KartengeneratorVariablenLogik.Kartenparameter.Kartenpole.Nordpol
      is
         when KartenartDatentypen.Kartenpol_Nicht_Vorhanden_Enum =>
            return;
            
         when KartenartDatentypen.Kartenpol_Vorhanden_Enum =>
            null;
      end case;
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartenKonstanten.AnfangSenkrechte .. KartengeneratorVariablenLogik.SenkrechtePolgrößen (KartenartDatentypen.Norden_Enum) loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartenKonstanten.AnfangWaagerechte .. LeseWeltkarteneinstellungen.Waagerechte loop
            
            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                          GrundExtern       => KartengeneratorVariablenLogik.PolgrundOberfläche);
            
            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.UnterflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                          GrundExtern       => KartengeneratorVariablenLogik.PolgrundUnterfläche);
            
         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
      
   end PolregionNorden;
   
   
   
   procedure PolregionSüden
   is
      use type KartenDatentypen.Senkrechte;
   begin
      
      case
        KartengeneratorVariablenLogik.Kartenparameter.Kartenpole.Südpol
      is
         when KartenartDatentypen.Kartenpol_Nicht_Vorhanden_Enum =>
            return;
            
         when KartenartDatentypen.Kartenpol_Vorhanden_Enum =>
            null;
      end case;

      -- Hier ist + 1 nötig, da er nicht wie auf der anderen Polseite bis zu dem Punkt loopt sondern eins weiter.
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in LeseWeltkarteneinstellungen.Senkrechte - KartengeneratorVariablenLogik.SenkrechtePolgrößen (KartenartDatentypen.Süden_Enum) + 1 .. LeseWeltkarteneinstellungen.Senkrechte loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartenKonstanten.AnfangWaagerechte .. LeseWeltkarteneinstellungen.Waagerechte loop
            
            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                          GrundExtern       => KartengeneratorVariablenLogik.PolgrundOberfläche);
            
            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.UnterflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                          GrundExtern       => KartengeneratorVariablenLogik.PolgrundUnterfläche);
            
         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
      
   end PolregionSüden;
   
   
   
   procedure PolregionWesten
   is begin
      
      case
        KartengeneratorVariablenLogik.Kartenparameter.Kartenpole.Westpol
      is
         when KartenartDatentypen.Kartenpol_Nicht_Vorhanden_Enum =>
            return;
            
         when KartenartDatentypen.Kartenpol_Vorhanden_Enum =>
            null;
      end case;
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartenKonstanten.AnfangSenkrechte .. LeseWeltkarteneinstellungen.Senkrechte loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartenKonstanten.AnfangWaagerechte .. KartengeneratorVariablenLogik.WaagerechtePolgrößen (KartenartDatentypen.Westen_Enum) loop
            
            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                          GrundExtern       => KartengeneratorVariablenLogik.PolgrundOberfläche);
            
            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.UnterflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                          GrundExtern       => KartengeneratorVariablenLogik.PolgrundUnterfläche);
            
         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
      
   end PolregionWesten;
   
   
   
   procedure PolregionOsten
   is
      use type KartenDatentypen.Waagerechte;
   begin
      
      case
        KartengeneratorVariablenLogik.Kartenparameter.Kartenpole.Ostpol
      is
         when KartenartDatentypen.Kartenpol_Nicht_Vorhanden_Enum =>
            return;
            
         when KartenartDatentypen.Kartenpol_Vorhanden_Enum =>
            null;
      end case;
      
      -- Hier ist + 1 nötig, da er nicht wie auf der anderen Polseite bis zu dem Punkt loopt sondern eins weiter.
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartenKonstanten.AnfangSenkrechte .. LeseWeltkarteneinstellungen.Senkrechte loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in LeseWeltkarteneinstellungen.Waagerechte - KartengeneratorVariablenLogik.WaagerechtePolgrößen (KartenartDatentypen.Osten_Enum) + 1
           .. LeseWeltkarteneinstellungen.Waagerechte loop
            
            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                          GrundExtern       => KartengeneratorVariablenLogik.PolgrundOberfläche);
            
            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.UnterflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                          GrundExtern       => KartengeneratorVariablenLogik.PolgrundUnterfläche);
            
         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
      
   end PolregionOsten;

end KartengeneratorPolregionLogik;
