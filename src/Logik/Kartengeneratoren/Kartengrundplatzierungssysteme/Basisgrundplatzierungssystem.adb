with KartenKonstanten;
with SystemDatentypen;
with KartenDatentypen;

with SchreibeWeltkarte;
with LeseWeltkarte;

with KartenkoordinatenberechnungssystemLogik;

package body Basisgrundplatzierungssystem is

   procedure Basisgrundplatzierung
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      BasisgrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum)
   is
      use type KartenDatentypen.SenkrechteBasis;
      use type KartenDatentypen.WaagerechteBasis;
   begin
      
      case
        BasisgrundExtern
      is
         when KartenbasisgrundDatentypen.Basisgrund_Berge_Enum'Range =>
            Grundumgebung := (others => False);
            
         when others =>
            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern,
                                          GrundExtern       => BasisgrundExtern);
            return;
      end case;
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartenDatentypen.SenkrechteUmgebungEins'Range loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartenDatentypen.WaagerechteUmgebungEins'Range loop
            
            Kartenwert := KartenkoordinatenberechnungssystemLogik.Koordinatenberechnung (KoordinatenExtern => KoordinatenExtern,
                                                                                         ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                         TaskExtern        => SystemDatentypen.Logik_Task_Enum);
            
            if
              Kartenwert.Waagerechte = KartenKonstanten.LeerWaagerechte
            then
               null;
                  
            elsif
              SenkrechteSchleifenwert = KartenKonstanten.LeerSenkrechteÄnderung
              and
                WaagerechteSchleifenwert = KartenKonstanten.WaagerechteWesten
            then
               Grundumgebung.Links := BerechnungLinks (KoordinatenExtern => Kartenwert);
               
            elsif
              SenkrechteSchleifenwert = KartenKonstanten.LeerSenkrechteÄnderung
              and
                WaagerechteSchleifenwert = KartenKonstanten.WaagerechteOsten
            then
               Grundumgebung.Rechts := BerechnungRechts (KoordinatenExtern => Kartenwert);
               
            elsif
              SenkrechteSchleifenwert = KartenKonstanten.SenkrechteNorden
              and
                WaagerechteSchleifenwert = KartenKonstanten.LeerWaagerechteÄnderung
            then
               Grundumgebung.Oben := BerechnungOben (KoordinatenExtern => Kartenwert);
               
            elsif
              SenkrechteSchleifenwert = KartenKonstanten.SenkrechteSüden
              and
                WaagerechteSchleifenwert = KartenKonstanten.LeerWaagerechteÄnderung
            then
               Grundumgebung.Unten := BerechnungUnten (KoordinatenExtern => Kartenwert);
               
            else
               null;
            end if;
            
         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
      
      
      case
        BasisgrundExtern
      is
         when KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Range =>
            GrundSchreiben := KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum'Val (Basisgrundwert (Grundumgebung.Links, Grundumgebung.Rechts, Grundumgebung.Oben, Grundumgebung.Unten) + Hügelzusatz);
            
         when KartenbasisgrundDatentypen.Basisgrund_Gebirge_Enum'Range =>
            GrundSchreiben := KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum'Val (Basisgrundwert (Grundumgebung.Links, Grundumgebung.Rechts, Grundumgebung.Oben, Grundumgebung.Unten) + Gebirgezusatz);
            
         when others =>
            return;
      end case;
      
      SchreibeWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern,
                                    GrundExtern       => GrundSchreiben);
      
   end Basisgrundplatzierung;
   
   
   
   function BerechnungLinks
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
   is begin
      
      WelcherGrund := LeseWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherGrund
      is
         when KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Range =>
            Umrechnungswert := Hügelzusatz;
            
         when KartenbasisgrundDatentypen.Basisgrund_Gebirge_Enum'Range =>
            Umrechnungswert := Gebirgezusatz;
            
         when others =>
            return False;
      end case;
           
      WelcherGrund := KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum'Val (KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum'Pos (WelcherGrund) - Umrechnungswert);
      SchreibeWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern,
                                    GrundExtern       => KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum'Val (BasisgrundLinks (WelcherGrund) + Umrechnungswert));
      
      return True;
                  
   end BerechnungLinks;
   
   
   
   function BerechnungRechts
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
   is begin
      
      WelcherGrund := LeseWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherGrund
      is
         when KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Range =>
            Umrechnungswert := Hügelzusatz;
            
         when KartenbasisgrundDatentypen.Basisgrund_Gebirge_Enum'Range =>
            Umrechnungswert := Gebirgezusatz;
            
         when others =>
            return False;
      end case;
           
      WelcherGrund := KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum'Val (KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum'Pos (WelcherGrund) - Umrechnungswert);
      SchreibeWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern,
                                    GrundExtern       => KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum'Val (BasisgrundRechts (WelcherGrund) + Umrechnungswert));
      
      return True;
      
   end BerechnungRechts;
   
   
   
   function BerechnungOben
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
   is begin
      
      WelcherGrund := LeseWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherGrund
      is
         when KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Range =>
            Umrechnungswert := Hügelzusatz;
            
         when KartenbasisgrundDatentypen.Basisgrund_Gebirge_Enum'Range =>
            Umrechnungswert := Gebirgezusatz;
            
         when others =>
            return False;
      end case;
           
      WelcherGrund := KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum'Val (KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum'Pos (WelcherGrund) - Umrechnungswert);
      SchreibeWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern,
                                    GrundExtern       => KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum'Val (BasisgrundOben (WelcherGrund) + Umrechnungswert));
   
      return True;
            
   end BerechnungOben;
   
   
   
   function BerechnungUnten
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
   is begin
      
      WelcherGrund := LeseWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherGrund
      is
         when KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Range =>
            Umrechnungswert := Hügelzusatz;
            
         when KartenbasisgrundDatentypen.Basisgrund_Gebirge_Enum'Range =>
            Umrechnungswert := Gebirgezusatz;
            
         when others =>
            return False;
      end case;
           
      WelcherGrund := KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum'Val (KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum'Pos (WelcherGrund) - Umrechnungswert);
      SchreibeWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern,
                                    GrundExtern       => KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum'Val (BasisgrundUnten (WelcherGrund) + Umrechnungswert));
   
      return True;
      
   end BerechnungUnten;

end Basisgrundplatzierungssystem;
