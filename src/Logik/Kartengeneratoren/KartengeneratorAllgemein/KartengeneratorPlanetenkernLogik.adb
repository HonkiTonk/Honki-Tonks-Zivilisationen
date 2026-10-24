with ZufallsgeneratorenHTSEB;

with KartenbasisgrundDatentypen;

with LadezeitenDatentypen;
with KartenKonstanten;

with SchreibeWeltkarte;
with LeseWeltkarte;

with LadezeitenLogik;

package body KartengeneratorPlanetenkernLogik is

   procedure Planetenkern
     (LadezeitbasisExtern : in Float)
   is begin
      
      Karteneinstellung := (LeseWeltkarteneinstellungen.Senkrechte, LeseWeltkarteneinstellungen.Waagerechte);
      
      Kernbereich := (Karteneinstellung.Senkrechte / 2 - Karteneinstellung.Senkrechte / 10,
                      Karteneinstellung.Senkrechte / 2 + Karteneinstellung.Senkrechte / 10,
                      Karteneinstellung.Waagerechte / 2 - Karteneinstellung.Waagerechte / 10,
                      Karteneinstellung.Waagerechte / 2 + Karteneinstellung.Waagerechte / 10);
               
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartenKonstanten.AnfangSenkrechte .. Karteneinstellung.Senkrechte loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartenKonstanten.AnfangWaagerechte .. Karteneinstellung.Waagerechte loop
            
            if
              SenkrechteSchleifenwert in Kernbereich.MinimaleSenkrechte .. Kernbereich.MaximaleSenkrechte
              and
                WaagerechteSchleifenwert in Kernbereich.MinimaleWaagerechte .. Kernbereich.MaximaleWaagerechte
            then
               SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.KernKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                             GrundExtern       => KartenbasisgrundDatentypen.Planetenkern_Enum);
               
            elsif
              SenkrechteSchleifenwert in Kernbereich.MinimaleSenkrechte - 1 .. Kernbereich.MaximaleSenkrechte + 1
              and
                WaagerechteSchleifenwert in Kernbereich.MinimaleWaagerechte - 1 .. Kernbereich.MaximaleWaagerechte + 1
            then
               SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.KernKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                             GrundExtern       => KartenbasisgrundDatentypen.Lava_Enum);
               
            else
               LandVorhanden (SenkrechteExtern  => SenkrechteSchleifenwert,
                              WaagerechteExtern => WaagerechteSchleifenwert);
            end if;
               
         end loop WaagerechteSchleife;
         
         LadezeitenLogik.KartengeneratorSchreiben (BerechnungszeitExtern => LadezeitenDatentypen.Generiere_Allgemeines_Enum,
                                                   ZeitExtern            => LadezeitbasisExtern);
         
      end loop SenkrechteSchleife;
               
   end Planetenkern;
   
   
   
   procedure LandVorhanden
     (SenkrechteExtern : in KartenDatentypen.SenkrechtePositiv;
      WaagerechteExtern : in KartenDatentypen.WaagerechtePositiv)
   is
      use type SystemDatentypenHTSEB.NullBisHundert;
   begin
      
      case
        LeseWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.KernKonstante, SenkrechteExtern, WaagerechteExtern))
      is
         when KartenbasisgrundDatentypen.Leer_Basisgrund_Enum =>
            BeliebigerLandwert := ZufallsgeneratorenHTSEB.Hunderterbereich;
            
            if
              BeliebigerLandwert < WahrscheinlichkeitFestmasse.Anfangswert
            then
               SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteExtern, WaagerechteExtern),
                                             GrundExtern       => KartenbasisgrundDatentypen.Lava_Enum);
         
            elsif
              BeliebigerLandwert > WahrscheinlichkeitFestmasse.Endwert
            then
               SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteExtern, WaagerechteExtern),
                                             GrundExtern       => KartenbasisgrundDatentypen.Ringwoodit_Enum);
               
            else
               null;
               -- LandmasseAbstandGenerieren (SenkrechteExtern => SenkrechteExtern,
               --                            WaagerechteExtern => WaagerechteExtern);
            end if;
            
         when others =>
            null;
      end case;
      
   end LandVorhanden;

end KartengeneratorPlanetenkernLogik;
