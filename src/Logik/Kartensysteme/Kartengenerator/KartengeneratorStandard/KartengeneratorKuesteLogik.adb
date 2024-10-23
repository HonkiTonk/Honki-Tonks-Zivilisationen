with KartengrundDatentypen;
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
      
      Kartenzeitwert := Basiszeitwert (ZusatzwertExtern => LeseWeltkarteneinstellungen.Senkrechte,
                                       TeilerExtern     => 100);
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartenKonstanten.AnfangSenkrechte .. LeseWeltkarteneinstellungen.Senkrechte loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartenKonstanten.AnfangWaagerechte .. LeseWeltkarteneinstellungen.Waagerechte loop
                              
            case
              LeseWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert))
            is
               when KartengrundDatentypen.Wasser_Enum =>
                  GewässerFestlegen (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  
               when others =>
                  null;
            end case;
            
         end loop WaagerechteSchleife;
            
         case
           SenkrechteSchleifenwert mod Kartenzeitwert
         is
            when 0 =>
               LadezeitenLogik.FortschrittSpielweltSchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Küstenwasser_Enum);
               
            when others =>
               null;
         end case;
         
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
                  when KartengrundDatentypen.Flachland_Enum | KartengrundDatentypen.Eis_Enum =>
                     SchreibeWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern,
                                                   GrundExtern       => KartengrundDatentypen.Küstengewässer_Enum);
                     return;
                     
                  when others =>
                     null;
               end case;
            end if;
                        
         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
      
   end GewässerFestlegen;

end KartengeneratorKuesteLogik;
