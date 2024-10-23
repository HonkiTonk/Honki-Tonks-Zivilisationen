with KartenKonstanten;
with SystemDatentypen;

with SchreibeWeltkarte;
with LeseWeltkarte;

with KartenkoordinatenberechnungssystemLogik;

package body Zusatzgrundplatzierungssystem is
   
   procedure Zusatzgrundentfernung
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
   is
      use type KartengrundDatentypen.Zusatzgrund_Enum;
   begin
            
      AktuellerGrund := LeseWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern);
            
      case
        AktuellerGrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            return;
            
         when others =>
            SchreibeWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern,
                                           GrundExtern       => KartengrundDatentypen.Leer_Zusatzgrund_Enum);
      end case;
      
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
                     NebenfeldGrund := LeseWeltkarte.Zusatzgrund (KoordinatenExtern => Entfernungskartenwert);
                     
                     if
                       NebenfeldGrund = KartengrundDatentypen.Leer_Zusatzgrund_Enum
                     then
                        null;
                        
                     elsif
                       GrundZuNummer (AktuellerGrund) /= GrundZuNummer (NebenfeldGrund)
                     then
                        null;
                  
                     else
                        Zusatzgrundplatzierung (KoordinatenExtern => Entfernungskartenwert,
                                                ZusatzgrundExtern => AktuellerGrund);
                     end if;
               end case;
            end if;
            
         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
      
   end Zusatzgrundentfernung;
   
   

   procedure Zusatzgrundplatzierung
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      ZusatzgrundExtern : in KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum)
   is begin
      
      Grundumgebung := (others => False);
      Grundnummer := GrundZuNummer (ZusatzgrundExtern);
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartenDatentypen.SenkrechteUmgebungEins'Range loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartenDatentypen.WaagerechteUmgebungEins'Range loop
            
            Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
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
               Grundumgebung.Links := BerechnungLinks (KoordinatenExtern => Kartenwert,
                                                       GrundnummerExtern => Grundnummer);
               
            elsif
              SenkrechteSchleifenwert = KartenKonstanten.LeerSenkrechteÄnderung
              and
                WaagerechteSchleifenwert = KartenKonstanten.WaagerechteOsten
            then
               Grundumgebung.Rechts := BerechnungRechts (KoordinatenExtern => Kartenwert,
                                                         GrundnummerExtern => Grundnummer);
               
            elsif
              SenkrechteSchleifenwert = KartenKonstanten.SenkrechteNorden
              and
                WaagerechteSchleifenwert = KartenKonstanten.LeerWaagerechteÄnderung
            then
               Grundumgebung.Oben := BerechnungOben (KoordinatenExtern => Kartenwert,
                                                     GrundnummerExtern => Grundnummer);
               
            elsif
              SenkrechteSchleifenwert = KartenKonstanten.SenkrechteSüden
              and
                WaagerechteSchleifenwert = KartenKonstanten.LeerWaagerechteÄnderung
            then
               Grundumgebung.Unten := BerechnungUnten (KoordinatenExtern => Kartenwert,
                                                       GrundnummerExtern => Grundnummer);
               
            else
               null;
            end if;
            
         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
      
      SchreibeWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern,
                                     GrundExtern       => KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Val (Zusatzgrundwert (Grundumgebung.Links, Grundumgebung.Rechts,
                                       Grundumgebung.Oben, Grundumgebung.Unten) + Zusatzgrundtyp (Grundnummer)));
            
   end Zusatzgrundplatzierung;
   
   
   
   function BerechnungLinks
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      GrundnummerExtern : in Positive)
      return Boolean
   is begin
      
      WelcherGrund := LeseWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherGrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            return False;
         
         when others =>
            AndersfeldigeGrundnummer := GrundZuNummer (WelcherGrund);
      end case;
      
      if
        AndersfeldigeGrundnummer /= GrundnummerExtern
      then
         return False;
            
      else
         WelcherGrund := KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Val (KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Pos (WelcherGrund) - Zusatzgrundtyp (AndersfeldigeGrundnummer));
         SchreibeWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern,
                                        GrundExtern       => KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Val (ZusatzgrundLinks (WelcherGrund) + Zusatzgrundtyp (AndersfeldigeGrundnummer)));
         return True;
      end if;
            
   end BerechnungLinks;
   
   
   
   function BerechnungRechts
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      GrundnummerExtern : in Positive)
      return Boolean
   is begin
      
      WelcherGrund := LeseWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherGrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            return False;
         
         when others =>
            AndersfeldigeGrundnummer := GrundZuNummer (WelcherGrund);
      end case;
      
      if
        AndersfeldigeGrundnummer /= GrundnummerExtern
      then
         return False;
            
      else
         WelcherGrund := KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Val (KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Pos (WelcherGrund) - Zusatzgrundtyp (AndersfeldigeGrundnummer));
         SchreibeWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern,
                                        GrundExtern       => KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Val (ZusatzgrundRechts (WelcherGrund) + Zusatzgrundtyp (AndersfeldigeGrundnummer)));
         return True;
      end if;
      
   end BerechnungRechts;
   
   
   
   function BerechnungOben
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      GrundnummerExtern : in Positive)
      return Boolean
   is begin
      
      WelcherGrund := LeseWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherGrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            return False;
         
         when others =>
            AndersfeldigeGrundnummer := GrundZuNummer (WelcherGrund);
      end case;
      
      if
        AndersfeldigeGrundnummer /= GrundnummerExtern
      then
         return False;
            
      else
         WelcherGrund := KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Val (KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Pos (WelcherGrund) - Zusatzgrundtyp (AndersfeldigeGrundnummer));
         SchreibeWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern,
                                        GrundExtern       => KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Val (ZusatzgrundOben (WelcherGrund) + Zusatzgrundtyp (AndersfeldigeGrundnummer)));
         return True;
      end if;
            
   end BerechnungOben;
   
   
   
   function BerechnungUnten
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      GrundnummerExtern : in Positive)
      return Boolean
   is begin
      
      WelcherGrund := LeseWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherGrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            return False;
         
         when others =>
            AndersfeldigeGrundnummer := GrundZuNummer (WelcherGrund);
      end case;
      
      if
        AndersfeldigeGrundnummer /= GrundnummerExtern
      then
         return False;
            
      else
         WelcherGrund := KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Val (KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Pos (WelcherGrund) - Zusatzgrundtyp (AndersfeldigeGrundnummer));
         SchreibeWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern,
                                        GrundExtern       => KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Val (ZusatzgrundUnten (WelcherGrund) + Zusatzgrundtyp (AndersfeldigeGrundnummer)));
         return True;
      end if;
      
   end BerechnungUnten;

end Zusatzgrundplatzierungssystem;
