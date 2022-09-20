pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen; use KartengrundDatentypen;
with LadezeitenDatentypen;
with KartenKonstanten;

with SchreibeWeltkarte;
with LeseWeltkarte;

with ZufallsgeneratorenKarten;
with KartenkoordinatenberechnungssystemLogik;
with KartengeneratorVariablen;
with LadezeitenLogik;

package body KartengeneratorLandschaftLogik is

   procedure GenerierungLandschaft
   is begin
      
      Kartenzeitwert := (KartengeneratorVariablen.SchleifenendeOhnePolbereich.YAchse + (100 - 1)) / 100;
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.YAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.XAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.XAchse loop
            
            case
              LeseWeltkarte.AktuellerGrund (KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert))
            is
               when KartengrundDatentypen.Flachland_Enum =>
                  BasisgrundBestimmen (KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert));

               when others =>
                  null;
            end case;
            
            case
              LeseWeltkarte.AktuellerGrund (KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert))
            is
               when KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum =>
                  ZusatzgrundBestimmen (KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert));

               when others =>
                  null;
            end case;
            
         end loop XAchseSchleife;
            
         case
           YAchseSchleifenwert mod Kartenzeitwert
         is
            when 0 =>
               LadezeitenLogik.FortschrittSpielweltSchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Landschaft_Enum);
               
            when others =>
               null;
         end case;
         
      end loop YAchseSchleife;
      
   end GenerierungLandschaft;
   
   
   
   procedure BasisgrundBestimmen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord)
   is begin
      
      WelcherGrund := KartengrundDatentypen.Leer_Grund_Enum;
      
      ZufallszahlenSchleife:
      for ZufallszahlSchleifenwert in BasisWahrscheinlichkeitenArray'Range loop
         
         BasisZahlen (ZufallszahlSchleifenwert) := ZufallsgeneratorenKarten.KartengeneratorZufallswerte;
         
         if
           BasisZahlen (ZufallszahlSchleifenwert) < BasisWahrscheinlichkeiten (ZufallszahlSchleifenwert)
         then
            BasisMöglichkeiten (ZufallszahlSchleifenwert) := True;
            
         else
            BasisMöglichkeiten (ZufallszahlSchleifenwert) := False;
         end if;
         
      end loop ZufallszahlenSchleife;
      
      DurchlaufSchleife:
      for DurchlaufSchleifenwert in Boolean'Range loop
         WahrscheinlichkeitSchleife:
         for WahrscheinlichkeitSchleifenwert in BasisWahrscheinlichkeitenArray'Range loop
            
            if
              DurchlaufSchleifenwert = False
              and
                BasisMöglichkeiten (WahrscheinlichkeitSchleifenwert) = False
            then
               null;
                  
            else
               case
                 WelcherGrund
               is
                  when KartengrundDatentypen.Leer_Grund_Enum =>
                     WelcherGrund := WahrscheinlichkeitSchleifenwert;
                        
                  when others =>
                     if
                       BasisZahlen (WahrscheinlichkeitSchleifenwert) > BasisZahlen (WelcherGrund)
                     then
                        WelcherGrund := WahrscheinlichkeitSchleifenwert;
                        
                     elsif
                       BasisZahlen (WahrscheinlichkeitSchleifenwert) = BasisZahlen (WelcherGrund)
                       and
                         ZufallsgeneratorenKarten.KartengeneratorBoolean = True
                     then
                        WelcherGrund := WahrscheinlichkeitSchleifenwert;
                           
                     else
                        null;
                     end if;
               end case;
            end if;
               
         end loop WahrscheinlichkeitSchleife;
      
         case
           WelcherGrund
         is
            when KartengrundDatentypen.Leer_Grund_Enum =>
               null;
            
            when others =>
               exit DurchlaufSchleife;
         end case;
         
      end loop DurchlaufSchleife;
      
      WelcherGrund := BasisExtraberechnungen (KoordinatenExtern => KoordinatenExtern,
                                              GrundExtern       => WelcherGrund);
      
      SchreibeWeltkarte.GleicherGrund (KoordinatenExtern => (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse),
                                       GrundExtern       => WelcherGrund);
      
   end BasisgrundBestimmen;
   
   
   
   procedure ZusatzgrundBestimmen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord)
   is begin
      
      WelcherGrund := KartengrundDatentypen.Leer_Grund_Enum;
      
      ZufallszahlenSchleife:
      for ZufallszahlSchleifenwert in ZusatzWahrscheinlichkeitenArray'Range loop
         
         ZusatzZahlen (ZufallszahlSchleifenwert) := ZufallsgeneratorenKarten.KartengeneratorZufallswerte;
         
         if
           ZusatzZahlen (ZufallszahlSchleifenwert) < ZusatzWahrscheinlichkeiten (ZufallszahlSchleifenwert)
         then
            ZusatzMöglichkeiten (ZufallszahlSchleifenwert) := True;
            
         else
            ZusatzMöglichkeiten (ZufallszahlSchleifenwert) := False;
         end if;
         
      end loop ZufallszahlenSchleife;
      
      WahrscheinlichkeitSchleife:
      for WahrscheinlichkeitSchleifenwert in ZusatzWahrscheinlichkeitenArray'Range loop
            
         if
           ZusatzMöglichkeiten (WahrscheinlichkeitSchleifenwert) = False
         then
            null;
         
         else
            case
              WelcherGrund
            is
               when KartengrundDatentypen.Leer_Grund_Enum =>
                  WelcherGrund := WahrscheinlichkeitSchleifenwert; 
                        
               when others =>
                  if
                    ZusatzZahlen (WahrscheinlichkeitSchleifenwert) > ZusatzZahlen (WelcherGrund)
                  then
                     WelcherGrund := WahrscheinlichkeitSchleifenwert;
                        
                  elsif
                    ZusatzZahlen (WahrscheinlichkeitSchleifenwert) = ZusatzZahlen (WelcherGrund)
                    and
                      ZufallsgeneratorenKarten.KartengeneratorBoolean = True
                  then
                     WelcherGrund := WahrscheinlichkeitSchleifenwert;
                           
                  else
                     null;
                  end if;
            end case;
         end if;
            
      end loop WahrscheinlichkeitSchleife;
      
      case
        WelcherGrund
      is
         when KartengrundDatentypen.Leer_Grund_Enum =>
            return;
            
         when others =>
            WelcherGrund := ZusatzExtraberechnungen (KoordinatenExtern => KoordinatenExtern,
                                                     GrundExtern       => WelcherGrund);
      end case;
            
      case
        WelcherGrund
      is
         when KartengrundDatentypen.Kartengrund_Oberfläche_Zusatz_Enum'Range =>
            SchreibeWeltkarte.AktuellerGrund (KoordinatenExtern => (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse),
                                              GrundExtern       => WelcherGrund);
            
         when others =>
            null;
      end case;
            
   end ZusatzgrundBestimmen;
   
   
   
   function BasisExtraberechnungen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum)
      return KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum
   is begin
     
      case
        GrundExtern
      is
         when KartengrundDatentypen.Tundra_Enum =>
            return ZusatzberechnungTundra (KoordinatenExtern => KoordinatenExtern,
                                           GrundExtern       => GrundExtern);
            
         when KartengrundDatentypen.Wüste_Enum =>
            return ZusatzberechnungWüste (KoordinatenExtern => KoordinatenExtern,
                                           GrundExtern       => GrundExtern);
            
         when KartengrundDatentypen.Hügel_Enum =>
            return ZusatzberechnungHügel (KoordinatenExtern => KoordinatenExtern,
                                           GrundExtern       => GrundExtern);
            
         when KartengrundDatentypen.Gebirge_Enum =>
            return ZusatzberechnungGebirge (KoordinatenExtern => KoordinatenExtern,
                                            GrundExtern       => GrundExtern);
            
         when KartengrundDatentypen.Flachland_Enum =>
            return ZusatzberechnungFlachland (KoordinatenExtern => KoordinatenExtern,
                                              GrundExtern       => GrundExtern);
      end case;
   
   end BasisExtraberechnungen;
   
   
   
   function ZusatzExtraberechnungen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Zusatz_Enum)
      return KartengrundDatentypen.Kartengrund_Enum
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Wald_Enum =>
            return ZusatzberechnungWald (KoordinatenExtern => KoordinatenExtern,
                                         GrundExtern       => GrundExtern);
            
         when KartengrundDatentypen.Dschungel_Enum =>
            return ZusatzberechnungDschungel (KoordinatenExtern => KoordinatenExtern,
                                              GrundExtern       => GrundExtern);
            
         when KartengrundDatentypen.Sumpf_Enum =>
            return ZusatzberechnungSumpf (KoordinatenExtern => KoordinatenExtern,
                                          GrundExtern       => GrundExtern);
      end case;
   
   end ZusatzExtraberechnungen;
   
   
   
   function ZusatzberechnungTundra
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum)
      return KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse),
                                                                                                      ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      LogikGrafikExtern => True);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              LeseWeltkarte.AktuellerGrund (KoordinatenExtern => KartenWert) = KartengrundDatentypen.Wüste_Enum
            then
               return KartengrundDatentypen.Wüste_Enum;
                  
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      return GrundExtern;
      
   end ZusatzberechnungTundra;
   
   
   
   function ZusatzberechnungWüste
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum)
      return KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse),
                                                                                                      ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      LogikGrafikExtern => True);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              LeseWeltkarte.AktuellerGrund (KoordinatenExtern => KartenWert) = KartengrundDatentypen.Eis_Enum
              or
                LeseWeltkarte.AktuellerGrund (KoordinatenExtern => KartenWert) = KartengrundDatentypen.Tundra_Enum
            then
               return KartengrundDatentypen.Tundra_Enum;
                  
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      return GrundExtern;
      
   end ZusatzberechnungWüste;
   
   
   
   function ZusatzberechnungHügel
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum)
      return KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum
   is begin
      
      if
        KoordinatenExtern.YAchse = KoordinatenExtern.XAchse
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungHügel;
   
   
   
   function ZusatzberechnungGebirge
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum)
      return KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum
   is begin
      
      if
        KoordinatenExtern.YAchse = KoordinatenExtern.XAchse
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungGebirge;
   
   
   
   function ZusatzberechnungFlachland
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum)
      return KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum
   is begin
         
      if
        KoordinatenExtern.YAchse = KoordinatenExtern.XAchse
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungFlachland;
   
   
   
   function ZusatzberechnungWald
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Zusatz_Enum)
      return KartengrundDatentypen.Kartengrund_Enum
   is begin
      
      BasisGrund := LeseWeltkarte.BasisGrund (KoordinatenExtern => (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse));
      
      if
        BasisGrund = KartengrundDatentypen.Wüste_Enum
      then
         return KartengrundDatentypen.Leer_Grund_Enum;
         
      else
         return GrundExtern;
      end if;
      
   end ZusatzberechnungWald;
   
   
   
   function ZusatzberechnungDschungel
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Zusatz_Enum)
      return KartengrundDatentypen.Kartengrund_Enum
   is begin
      
      BasisGrund := LeseWeltkarte.BasisGrund (KoordinatenExtern => (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse));
      
      if
        BasisGrund = KartengrundDatentypen.Wüste_Enum
        or
          BasisGrund = KartengrundDatentypen.Tundra_Enum
      then
         return KartengrundDatentypen.Leer_Grund_Enum;
         
      else
         return GrundExtern;
      end if;
            
   end ZusatzberechnungDschungel;
   
   
   
   function ZusatzberechnungSumpf
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Zusatz_Enum)
      return KartengrundDatentypen.Kartengrund_Enum
   is begin
      
      BasisGrund := LeseWeltkarte.BasisGrund (KoordinatenExtern => (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse));
      
      if
        BasisGrund = KartengrundDatentypen.Wüste_Enum
      then
         return KartengrundDatentypen.Leer_Grund_Enum;
         
      else
         return GrundExtern;
      end if;
      
   end ZusatzberechnungSumpf;

end KartengeneratorLandschaftLogik;
