with SystemDatentypen;

with LeseWeltkarte;
with SchreibeWeltkarte;

with KartenkoordinatenberechnungssystemLogik;

package body FlussplatzierungssystemLogik is

   procedure Flussplatzierung
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
   is begin
      
      Flussseite := (others => False);
      
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
               Flussseite.Links := BerechnungLinks (KoordinatenExtern => KartenWert);
               
            elsif
              SenkrechteSchleifenwert = KartenKonstanten.LeerSenkrechteÄnderung
              and
                WaagerechteSchleifenwert = KartenKonstanten.WaagerechteOsten
            then
               Flussseite.Rechts := BerechnungRechts (KoordinatenExtern => KartenWert);
               
            elsif
              SenkrechteSchleifenwert = KartenKonstanten.SenkrechteNorden
              and
                WaagerechteSchleifenwert = KartenKonstanten.LeerWaagerechteÄnderung
            then
               Flussseite.Oben := BerechnungOben (KoordinatenExtern => KartenWert);
               
            elsif
              SenkrechteSchleifenwert = KartenKonstanten.SenkrechteSüden
              and
                WaagerechteSchleifenwert = KartenKonstanten.LeerWaagerechteÄnderung
            then
               Flussseite.Unten := BerechnungUnten (KoordinatenExtern => KartenWert);
               
            else
               null;
            end if;
            
         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;

      SchreibeWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern,
                               FlussExtern       => KartenextraDatentypen.Fluss_Enum'Val (Flusswert (Flussseite.Links, Flussseite.Rechts,
                                 Flussseite.Oben, Flussseite.Unten) + Flusstyp (KoordinatenExtern.Ebene)));
      
   end Flussplatzierung;
   
   
   
   function BerechnungLinks
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
   is begin
      
      WelcherFluss := LeseWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherFluss
      is
         when KartenextraDatentypen.Leer_Fluss_Enum =>
            return False;
            
         when others =>
            WelcherFluss := KartenextraDatentypen.Fluss_Oberfläche_Enum'Val (KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (WelcherFluss) - Flusstyp (KoordinatenExtern.Ebene));
            SchreibeWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern,
                                     FlussExtern       => KartenextraDatentypen.Fluss_Enum'Val (FlüsseLinks (WelcherFluss) + Flusstyp (KoordinatenExtern.Ebene)));
            return True;
      end case;
            
   end BerechnungLinks;
   
   
   
   function BerechnungRechts
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
   is begin
      
      WelcherFluss := LeseWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherFluss
      is
         when KartenextraDatentypen.Leer_Fluss_Enum =>
            return False;
            
         when others =>
            WelcherFluss := KartenextraDatentypen.Fluss_Oberfläche_Enum'Val (KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (WelcherFluss) - Flusstyp (KoordinatenExtern.Ebene));
            SchreibeWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern,
                                     FlussExtern       => KartenextraDatentypen.Fluss_Enum'Val (FlüsseRechts (WelcherFluss) + Flusstyp (KoordinatenExtern.Ebene)));
            return True;
      end case;
      
   end BerechnungRechts;
   
   
   
   function BerechnungOben
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
   is begin
      
      WelcherFluss := LeseWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherFluss
      is
         when KartenextraDatentypen.Leer_Fluss_Enum =>
            return False;
            
         when others =>
            WelcherFluss := KartenextraDatentypen.Fluss_Oberfläche_Enum'Val (KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (WelcherFluss) - Flusstyp (KoordinatenExtern.Ebene));
            SchreibeWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern,
                                     FlussExtern       => KartenextraDatentypen.Fluss_Enum'Val (FlüsseOben (WelcherFluss) + Flusstyp (KoordinatenExtern.Ebene)));
            return True;
      end case;
            
   end BerechnungOben;
   
   
   
   function BerechnungUnten
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
   is begin
      
      WelcherFluss := LeseWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherFluss
      is
         when KartenextraDatentypen.Leer_Fluss_Enum =>
            return False;
            
         when others =>
            WelcherFluss:= KartenextraDatentypen.Fluss_Oberfläche_Enum'Val (KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (WelcherFluss) - Flusstyp (KoordinatenExtern.Ebene));
            SchreibeWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern,
                                     FlussExtern       => KartenextraDatentypen.Fluss_Enum'Val (FlüsseUnten (WelcherFluss) + Flusstyp (KoordinatenExtern.Ebene)));
            return True;
      end case;
      
   end BerechnungUnten;

end FlussplatzierungssystemLogik;
