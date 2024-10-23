with KartenKonstanten;
with SystemDatentypen;

with LeseWeltkarte;
with SchreibeWeltkarte;

with KartenkoordinatenberechnungssystemLogik;

package body WegeplatzierungssystemLogik is
   
   procedure Wegentfernung
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
   is
      use type KartenverbesserungDatentypen.Weg_Enum;
   begin
      
      SchreibeWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern,
                             WegExtern         => KartenverbesserungDatentypen.Leer_Weg_Enum);
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartenDatentypen.SenkrechteUmgebungEins'Range loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartenDatentypen.WaagerechteUmgebungEins'Range loop
            
            if
            abs (SenkrechteSchleifenwert) = KartenDatentypen.Senkrechte (abs (WaagerechteSchleifenwert))
            then
               null;
               
            else
               Entfernungskartenwert
                 := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                                TaskExtern        => SystemDatentypen.Logik_Task_Enum);
            
               case
                 Entfernungskartenwert.Waagerechte
               is
                  when KartenKonstanten.LeerWaagerechte =>
                     null;
               
                  when others =>
                     EntfernungWeg := LeseWeltkarte.Weg (KoordinatenExtern => Entfernungskartenwert);
                     
                     if
                       EntfernungWeg = KartenverbesserungDatentypen.Leer_Weg_Enum
                     then
                        null;
                        
                     else
                        Wegplatzierung (KoordinatenExtern => Entfernungskartenwert,
                                        WegartExtern      => StandardWeg (EntfernungWeg));
                     end if;
               end case;
            end if;
            
         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
      
   end Wegentfernung;
   
   

   procedure Wegplatzierung
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      WegartExtern : in AufgabenDatentypen.Einheitenbefehle_Wege_Enum)
   is begin
      
      Wegumgebung := (others => False);
      
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
               
            elsif
              SenkrechteSchleifenwert = KartenKonstanten.LeerSenkrechteÄnderung
              and
                WaagerechteSchleifenwert = KartenKonstanten.WaagerechteWesten
            then
               Wegumgebung.Links := BerechnungLinks (KoordinatenExtern => KartenWert);
               
            elsif
              SenkrechteSchleifenwert = KartenKonstanten.LeerSenkrechteÄnderung
              and
                WaagerechteSchleifenwert = KartenKonstanten.WaagerechteOsten
            then
               Wegumgebung.Rechts := BerechnungRechts (KoordinatenExtern => KartenWert);
               
            elsif
              SenkrechteSchleifenwert = KartenKonstanten.SenkrechteNorden
              and
                WaagerechteSchleifenwert = KartenKonstanten.LeerWaagerechteÄnderung
            then
               Wegumgebung.Oben := BerechnungOben (KoordinatenExtern => KartenWert);
               
            elsif
              SenkrechteSchleifenwert = KartenKonstanten.SenkrechteSüden
              and
                WaagerechteSchleifenwert = KartenKonstanten.LeerWaagerechteÄnderung
            then
               Wegumgebung.Unten := BerechnungUnten (KoordinatenExtern => KartenWert);
               
            else
               null;
            end if;
            
         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
      
      SchreibeWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern,
                             WegExtern         => KartenverbesserungDatentypen.Weg_Enum'Val (Wegwert (Wegumgebung.Links, Wegumgebung.Rechts, Wegumgebung.Oben, Wegumgebung.Unten) + Wegtyp (WegartExtern)));
      
   end Wegplatzierung;
   
   
   
   function BerechnungLinks
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
   is begin
      
      WelcherWeg := LeseWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherWeg
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            return False;
            
         when others =>
            ZwischenWeg := KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Val (KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Pos (WelcherWeg) - (Wegtyp (StandardWeg (WelcherWeg))));
            SchreibeWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern,
                                   WegExtern         => KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Val (WegeLinks (ZwischenWeg) + Wegtyp (StandardWeg (WelcherWeg))));
            return True;
      end case;
      
   end BerechnungLinks;
   
   
   
   function BerechnungRechts
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
   is begin
      
      WelcherWeg := LeseWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherWeg
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            return False;
            
         when others =>
            ZwischenWeg := KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Val (KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Pos (WelcherWeg) - (Wegtyp (StandardWeg (WelcherWeg))));
            SchreibeWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern,
                                   WegExtern         => KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Val (WegeRechts (ZwischenWeg) + Wegtyp (StandardWeg (WelcherWeg))));
            return True;
      end case;
      
   end BerechnungRechts;
   
   
                                
   function BerechnungOben
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
   is begin
      
      WelcherWeg := LeseWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherWeg
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            return False;
            
         when others =>
            ZwischenWeg := KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Val (KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Pos (WelcherWeg) - (Wegtyp (StandardWeg (WelcherWeg))));
            SchreibeWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern,
                                   WegExtern         => KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Val (WegeOben (ZwischenWeg) + Wegtyp (StandardWeg (WelcherWeg))));
            return True;
      end case;
      
   end BerechnungOben;
   
   
   
   function BerechnungUnten
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
   is begin
      
      WelcherWeg := LeseWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherWeg
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            return False;
            
         when others =>
            ZwischenWeg := KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Val (KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Pos (WelcherWeg) - (Wegtyp (StandardWeg (WelcherWeg))));
            SchreibeWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern,
                                   WegExtern         => KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Val (WegeUnten (ZwischenWeg) + Wegtyp (StandardWeg (WelcherWeg))));
            return True;
      end case;
      
   end BerechnungUnten;

end WegeplatzierungssystemLogik;
