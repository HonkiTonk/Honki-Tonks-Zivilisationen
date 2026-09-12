with KartenbasisgrundDatentypen;
with LadezeitenDatentypen;
with KartenKonstanten;
with SystemDatentypen;

with SchreibeWeltkarte;
with LeseWeltkarte;

with KartenkoordinatenberechnungssystemLogik;
with LadezeitenLogik;

package body KartengeneratorKuesteLogik is

   procedure GenerierungKüstenSeeGewässer
   is begin
      
      LadezeitBasis := 100.00 / Float (LeseWeltkarteneinstellungen.Senkrechte);
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartenKonstanten.AnfangSenkrechte .. LeseWeltkarteneinstellungen.Senkrechte loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartenKonstanten.AnfangWaagerechte .. LeseWeltkarteneinstellungen.Waagerechte loop
                              
            case
              LeseWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert))
            is
               when KartenbasisgrundDatentypen.Wasser_Enum =>
                  GewässerFestlegen (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  
               when others =>
                  null;
            end case;
            
         end loop WaagerechteSchleife;
         
         LadezeitenLogik.KartengeneratorSchreiben (BerechnungszeitExtern => LadezeitenDatentypen.Generiere_Küstenwasser_Enum,
                                                   ZeitExtern            => LadezeitBasis);
         
      end loop SenkrechteSchleife;
      
   end GenerierungKüstenSeeGewässer;
   
   
   
   procedure GewässerFestlegen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
   is begin
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartenDatentypen.SenkrechteUmgebungEins'Range loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartenDatentypen.WaagerechteUmgebungEins'Range loop
                     
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
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
                  when KartenbasisgrundDatentypen.Flachland_Enum | KartenbasisgrundDatentypen.Eis_Enum =>
                     SchreibeWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern,
                                                   GrundExtern       => KartenbasisgrundDatentypen.Küstengewässer_Enum);
                     return;
                     
                  when others =>
                     null;
               end case;
            end if;
                        
         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
      
   end GewässerFestlegen;

end KartengeneratorKuesteLogik;
