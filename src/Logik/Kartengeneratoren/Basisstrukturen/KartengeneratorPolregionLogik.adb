with KartenartDatentypen;
with KartenKonstanten;

with SchreibeWeltkarte;
with LeseWeltkarteneinstellungen;

with KartengeneratorVariablenLogik;

package body KartengeneratorPolregionLogik is
   
   procedure Polregion
   is
      use type KartenDatentypen.SenkrechteBasis;
      use type KartenDatentypen.WaagerechteBasis;
   begin
      
      Schleifenbereiche.MinimaleSenkrechte := KartenKonstanten.AnfangSenkrechte + KartengeneratorVariablenLogik.SenkrechterPolLesen (HimmelsrichtungExtern => KartenartDatentypen.Norden_Enum);
      
      Schleifenbereiche.MaximaleSenkrechte := LeseWeltkarteneinstellungen.Senkrechte - KartengeneratorVariablenLogik.SenkrechterPolLesen (HimmelsrichtungExtern => KartenartDatentypen.Süden_Enum);
      
      
      
      Schleifenbereiche.MinimaleWaagerechte := KartenKonstanten.AnfangWaagerechte + KartengeneratorVariablenLogik.WaagerechterPolLesen (HimmelsrichtungExtern => KartenartDatentypen.Westen_Enum);
      
      
      Schleifenbereiche.MaximaleWaagerechte := LeseWeltkarteneinstellungen.Waagerechte - KartengeneratorVariablenLogik.WaagerechterPolLesen (HimmelsrichtungExtern => KartenartDatentypen.Osten_Enum);
      
      KartengeneratorVariablenLogik.PolfreierBereichSchreiben (BereichExtern => Schleifenbereiche);
      
      PolregionGenerieren;

   end Polregion;
   
   

   procedure PolregionGenerieren
   is
      
      task Norden;
      task Süden;
      task Westen;
      task Osten;
      
      task body Norden
      is begin
         
         Nordpol;
         
      end Norden;
      
      
      
      task body Süden
      is begin
         
         Südpol;
         
      end Süden;
      
      
      
      task body Westen
      is begin
         
         Westpol;
         
      end Westen;
      
      
      
      task body Osten
      is begin
         
         Ostpol;
         
      end Osten;
   
   begin
      
      null;
      
   end PolregionGenerieren;
   
   
   
   procedure Nordpol
   is
      use type KartenDatentypen.EbeneVorhanden;
   begin
      
      case
        KartengeneratorVariablenLogik.KartenpoleLesen.Nordpol
      is
         when KartenartDatentypen.Kartenpol_Nicht_Vorhanden_Enum =>
            return;
            
         when KartenartDatentypen.Kartenpol_Vorhanden_Enum =>
            null;
      end case;
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartenKonstanten.AnfangSenkrechte .. KartengeneratorVariablenLogik.SenkrechterPolLesen (HimmelsrichtungExtern => KartenartDatentypen.Norden_Enum) loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartenKonstanten.AnfangWaagerechte .. LeseWeltkarteneinstellungen.Waagerechte loop
            
            if
              KartengeneratorVariablenLogik.KartenebenenLesen.EbeneEnde >= KartenKonstanten.OberflächeKonstante
            then
               SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                             GrundExtern       => KartengeneratorVariablenLogik.OberflächenpolLesen);
               
            else
               null;
            end if;
            
            if
              KartengeneratorVariablenLogik.KartenebenenLesen.EbeneAnfang <= KartenKonstanten.UnterflächeKonstante
            then
               SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.UnterflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                             GrundExtern       => KartengeneratorVariablenLogik.UnterflächenpolLesen);
               
            else
               null;
            end if;
            
         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
      
   end Nordpol;
   
   
   
   procedure Südpol
   is
      use type KartenDatentypen.SenkrechteBasis;
      use type KartenDatentypen.EbeneVorhanden;
   begin
      
      case
        KartengeneratorVariablenLogik.KartenpoleLesen.Südpol
      is
         when KartenartDatentypen.Kartenpol_Nicht_Vorhanden_Enum =>
            return;
            
         when KartenartDatentypen.Kartenpol_Vorhanden_Enum =>
            null;
      end case;

      -- Hier ist + 1 nötig, da er nicht wie auf der anderen Polseite bis zu dem Punkt loopt sondern eins weiter.
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in LeseWeltkarteneinstellungen.Senkrechte - KartengeneratorVariablenLogik.SenkrechterPolLesen (HimmelsrichtungExtern => KartenartDatentypen.Süden_Enum) + 1
        .. LeseWeltkarteneinstellungen.Senkrechte loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartenKonstanten.AnfangWaagerechte .. LeseWeltkarteneinstellungen.Waagerechte loop
            
            if
              KartengeneratorVariablenLogik.KartenebenenLesen.EbeneEnde >= KartenKonstanten.OberflächeKonstante
            then
               SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                             GrundExtern       => KartengeneratorVariablenLogik.OberflächenpolLesen);
               
            else
               null;
            end if;
            
            if
              KartengeneratorVariablenLogik.KartenebenenLesen.EbeneAnfang <= KartenKonstanten.UnterflächeKonstante
            then
               SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.UnterflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                             GrundExtern       => KartengeneratorVariablenLogik.UnterflächenpolLesen);
               
            else
               null;
            end if;
            
         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
      
   end Südpol;
   
   
   
   procedure Westpol
   is
      use type KartenDatentypen.EbeneVorhanden;
   begin
      
      case
        KartengeneratorVariablenLogik.KartenpoleLesen.Westpol
      is
         when KartenartDatentypen.Kartenpol_Nicht_Vorhanden_Enum =>
            return;
            
         when KartenartDatentypen.Kartenpol_Vorhanden_Enum =>
            null;
      end case;
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartenKonstanten.AnfangSenkrechte .. LeseWeltkarteneinstellungen.Senkrechte loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartenKonstanten.AnfangWaagerechte .. KartengeneratorVariablenLogik.WaagerechterPolLesen (HimmelsrichtungExtern => KartenartDatentypen.Westen_Enum) loop
            
            if
              KartengeneratorVariablenLogik.KartenebenenLesen.EbeneEnde >= KartenKonstanten.OberflächeKonstante
            then
               SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                             GrundExtern       => KartengeneratorVariablenLogik.OberflächenpolLesen);
               
            else
               null;
            end if;
            
            if
              KartengeneratorVariablenLogik.KartenebenenLesen.EbeneAnfang <= KartenKonstanten.UnterflächeKonstante
            then
               SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.UnterflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                             GrundExtern       => KartengeneratorVariablenLogik.UnterflächenpolLesen);
               
            else
               null;
            end if;
            
         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
      
   end Westpol;
   
   
   
   procedure Ostpol
   is
      use type KartenDatentypen.WaagerechteBasis;
      use type KartenDatentypen.EbeneVorhanden;
   begin
      
      case
        KartengeneratorVariablenLogik.KartenpoleLesen.Ostpol
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
         for WaagerechteSchleifenwert in LeseWeltkarteneinstellungen.Waagerechte - KartengeneratorVariablenLogik.WaagerechterPolLesen (HimmelsrichtungExtern => KartenartDatentypen.Osten_Enum) + 1
           .. LeseWeltkarteneinstellungen.Waagerechte loop
            
            if
              KartengeneratorVariablenLogik.KartenebenenLesen.EbeneEnde >= KartenKonstanten.OberflächeKonstante
            then
               SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                             GrundExtern       => KartengeneratorVariablenLogik.OberflächenpolLesen);
               
            else
               null;
            end if;
            
            if
              KartengeneratorVariablenLogik.KartenebenenLesen.EbeneAnfang <= KartenKonstanten.UnterflächeKonstante
            then
               SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.UnterflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                             GrundExtern       => KartengeneratorVariablenLogik.UnterflächenpolLesen);
               
            else
               null;
            end if;
            
         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
      
   end Ostpol;

end KartengeneratorPolregionLogik;
