with KartenDatentypen; use KartenDatentypen;
with KartenartDatentypen; use KartenartDatentypen;
with KartenKonstanten;
with Weltkarte;

with SchreibeWeltkarte;

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
      
      YAchseSchleife:
      for YAchseSchleifenwert in Weltkarte.KarteArray'First (2) .. KartengeneratorVariablenLogik.Polgrößen (KartenartDatentypen.Norden_Enum) loop
         XAchseSchleife:
         for XAchseSchleifenwert in Weltkarte.KarteArray'First (3) .. Weltkarte.Karteneinstellungen.Kartengröße.XAchse loop
            
            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, YAchseSchleifenwert, XAchseSchleifenwert),
                                          GrundExtern       => KartengeneratorVariablenLogik.PolgrundOberfläche);
            
            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.UnterflächeKonstante, YAchseSchleifenwert, XAchseSchleifenwert),
                                          GrundExtern       => KartengeneratorVariablenLogik.PolgrundUnterfläche);
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end PolregionNorden;
   
   
   
   procedure PolregionSüden
   is begin
      
      case
        KartengeneratorVariablenLogik.Kartenparameter.Kartenpole.Südpol
      is
         when KartenartDatentypen.Kartenpol_Nicht_Vorhanden_Enum =>
            return;
            
         when KartenartDatentypen.Kartenpol_Vorhanden_Enum =>
            null;
      end case;

      -- Hier ist + 1 nötig, da er nicht wie auf der anderen Polseite bis zu dem Punkt loopt sondern eins weiter.
      YAchseSchleife:
      for YAchseSchleifenwert in Weltkarte.Karteneinstellungen.Kartengröße.YAchse - KartengeneratorVariablenLogik.Polgrößen (KartenartDatentypen.Süden_Enum) + 1 .. Weltkarte.Karteneinstellungen.Kartengröße.YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in Weltkarte.KarteArray'First (3) .. Weltkarte.Karteneinstellungen.Kartengröße.XAchse loop
            
            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, YAchseSchleifenwert, XAchseSchleifenwert),
                                          GrundExtern       => KartengeneratorVariablenLogik.PolgrundOberfläche);
            
            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.UnterflächeKonstante, YAchseSchleifenwert, XAchseSchleifenwert),
                                          GrundExtern       => KartengeneratorVariablenLogik.PolgrundUnterfläche);
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
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
      
      YAchseSchleife:
      for YAchseSchleifenwert in Weltkarte.KarteArray'First (2) .. Weltkarte.Karteneinstellungen.Kartengröße.YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in Weltkarte.KarteArray'First (3) .. KartengeneratorVariablenLogik.Polgrößen (KartenartDatentypen.Westen_Enum) loop
            
            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, YAchseSchleifenwert, XAchseSchleifenwert),
                                          GrundExtern       => KartengeneratorVariablenLogik.PolgrundOberfläche);
            
            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.UnterflächeKonstante, YAchseSchleifenwert, XAchseSchleifenwert),
                                          GrundExtern       => KartengeneratorVariablenLogik.PolgrundUnterfläche);
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end PolregionWesten;
   
   
   
   procedure PolregionOsten
   is begin
      
      case
        KartengeneratorVariablenLogik.Kartenparameter.Kartenpole.Ostpol
      is
         when KartenartDatentypen.Kartenpol_Nicht_Vorhanden_Enum =>
            return;
            
         when KartenartDatentypen.Kartenpol_Vorhanden_Enum =>
            null;
      end case;
      
      -- Hier ist + 1 nötig, da er nicht wie auf der anderen Polseite bis zu dem Punkt loopt sondern eins weiter.
      YAchseSchleife:
      for YAchseSchleifenwert in Weltkarte.KarteArray'First (2) .. Weltkarte.Karteneinstellungen.Kartengröße.YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in Weltkarte.Karteneinstellungen.Kartengröße.XAchse - KartengeneratorVariablenLogik.Polgrößen (KartenartDatentypen.Osten_Enum) + 1
           .. Weltkarte.Karteneinstellungen.Kartengröße.XAchse loop
            
            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, YAchseSchleifenwert, XAchseSchleifenwert),
                                          GrundExtern       => KartengeneratorVariablenLogik.PolgrundOberfläche);
            
            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.UnterflächeKonstante, YAchseSchleifenwert, XAchseSchleifenwert),
                                          GrundExtern       => KartengeneratorVariablenLogik.PolgrundUnterfläche);
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end PolregionOsten;

end KartengeneratorPolregionLogik;
