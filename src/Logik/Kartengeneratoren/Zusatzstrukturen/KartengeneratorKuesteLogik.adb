with KartenbasisgrundDatentypen;
with LadezeitenDatentypen;
with KartenKonstanten;
with SystemDatentypen;

with SchreibeWeltkarte;
with LeseWeltkarte;

with KartenkoordinatenberechnungssystemLogik;
with LadezeitenLogik;
with KartengeneratorVariablenLogik;

package body KartengeneratorKuesteLogik is

   procedure Küste
   is begin
      
      Schleifenbereich := KartengeneratorVariablenLogik.PolfreierBereichLesen;
      
      Ladezeitbasis := 100.00 / Float (Schleifenbereich.MaximaleSenkrechte);
      
      case
        KartengeneratorVariablenLogik.KartenebenenLesen.EbeneEnde
      is
         when KartenKonstanten.UnterflächeKonstante =>
            AktuelleEbene := KartenKonstanten.UnterflächeKonstante;
            
         when others =>
            AktuelleEbene := KartenKonstanten.OberflächeKonstante;
      end case;
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in Schleifenbereich.MinimaleSenkrechte .. Schleifenbereich.MaximaleSenkrechte loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in Schleifenbereich.MinimaleWaagerechte .. Schleifenbereich.MaximaleWaagerechte loop
                              
            case
              LeseWeltkarte.Basisgrund (KoordinatenExtern => (AktuelleEbene, SenkrechteSchleifenwert, WaagerechteSchleifenwert))
            is
               when KartenbasisgrundDatentypen.Meer_Enum | KartenbasisgrundDatentypen.Meeresgrund_Enum =>
                  GewässerFestlegen (KoordinatenExtern => (AktuelleEbene, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  
               when others =>
                  null;
            end case;
            
         end loop WaagerechteSchleife;
         
         LadezeitenLogik.KartengeneratorSchreiben (BerechnungszeitExtern => LadezeitenDatentypen.Generiere_Küstenwasser_Enum,
                                                   ZeitExtern            => Ladezeitbasis);
         
      end loop SenkrechteSchleife;
      
   end Küste;
   
   
   
   procedure GewässerFestlegen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
   is begin
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartenDatentypen.SenkrechteUmgebungEins'Range loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartenDatentypen.WaagerechteUmgebungEins'Range loop
                     
            KartenWert := KartenkoordinatenberechnungssystemLogik.Koordinatenberechnung (KoordinatenExtern => KoordinatenExtern,
                                                                                         ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                         TaskExtern        => SystemDatentypen.Logik_Task_Enum);
                        
            if
              KartenWert.Waagerechte = KartenKonstanten.LeerWaagerechte
            then
               null;
               
            else
               case
                 LeseWeltkarte.Basisgrund (KoordinatenExtern => KartenWert)
               is
                  when KartenbasisgrundDatentypen.Grasland_Enum | KartenbasisgrundDatentypen.Eis_Enum | KartenbasisgrundDatentypen.Erde_Enum =>
                     KüsteSchreiben (KoordinatenExtern => KoordinatenExtern);
                     return;
                     
                  when others =>
                     null;
               end case;
            end if;
                        
         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
      
   end GewässerFestlegen;
   
   
   
   procedure KüsteSchreiben
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
   is
      use type KartenDatentypen.EbeneBasis;
   begin
      
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.OberflächeKonstante =>
            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern,
                                          GrundExtern       => KartenbasisgrundDatentypen.Küstengewässer_Enum);
      
            if
              KartengeneratorVariablenLogik.KartenebenenLesen.EbeneAnfang <= KartenKonstanten.UnterflächeKonstante
            then
               SchreibeWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern,
                                             GrundExtern       => KartenbasisgrundDatentypen.Küstengrund_Enum);
            
            else
               null;
            end if;
            
         when others =>
            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern,
                                          GrundExtern       => KartenbasisgrundDatentypen.Küstengrund_Enum);
      end case;
            
   end KüsteSchreiben;

end KartengeneratorKuesteLogik;
