with LadezeitenDatentypen;
with KartenKonstanten;

with LeseWeltkarte;

with ZufallsgeneratorenKartenLogik;
with KartenkoordinatenberechnungssystemLogik;
with KartengeneratorVariablenLogik;
with LadezeitenLogik;
with Zusatzgrundplatzierungssystem;
with ZufallsgeneratorenHTB6;
with Basisgrundplatzierungssystem;

package body KartengeneratorLandschaftLogik is

   procedure GenerierungLandschaft
   is begin
      
      Kartenzeitwert := Basiszeitwert (ZusatzwertExtern => KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte,
                                       TeilerExtern     => 100);
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.Senkrechte .. KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.Waagerechte .. KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Waagerechte loop
            
            case
              LeseWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert))
            is
               when KartengrundDatentypen.Flachland_Enum =>
                  BasisgrundBestimmen (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert));

               when others =>
                  null;
            end case;
            
            case
              LeseWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert))
            is
               when KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum =>
                  ZusatzgrundBestimmen (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert));

               when others =>
                  null;
            end case;
            
         end loop WaagerechteSchleife;
            
         case
           SenkrechteSchleifenwert mod Kartenzeitwert
         is
            when 0 =>
               LadezeitenLogik.FortschrittSpielweltSchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Landschaft_Enum);
               
            when others =>
               null;
         end case;
         
      end loop SenkrechteSchleife;
      
   end GenerierungLandschaft;
   
   
   
   procedure BasisgrundBestimmen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
   is
      use type SystemDatentypen.NullBisHundert;
   begin
      
      Zahlenspeicher := 0;
      WelcherGrund := 0;
      
      BasisgrundSchleife:
      loop
         ZufallszahlenSchleife:
         for ZufallszahlSchleifenwert in BasisWahrscheinlichkeitenArray'Range loop
         
            GezogeneZahl := ZufallsgeneratorenKartenLogik.KartengeneratorZufallswerte;
         
            if
              GezogeneZahl > BasisWahrscheinlichkeiten (ZufallszahlSchleifenwert)
              or
                GezogeneZahl = 0
            then
               null;
            
            elsif
              (GezogeneZahl = Zahlenspeicher
               and
                 ZufallsgeneratorenHTB6.Münzwurf = True)
              or
                GezogeneZahl > Zahlenspeicher
            then
               Zahlenspeicher := GezogeneZahl;
               WelcherGrund := ZufallszahlSchleifenwert;
            
            else
               null;
            end if;
         
         end loop ZufallszahlenSchleife;
         
         case
           WelcherGrund
         is
            when 0 =>
               null;
            
            when others =>
               exit BasisgrundSchleife;
         end case;
         
      end loop BasisgrundSchleife;
      
      Basisgrund := BasisExtraberechnungen (KoordinatenExtern => KoordinatenExtern,
                                            GrundExtern       => ZahlenNachBasisgrund (WelcherGrund));
      
      Basisgrundplatzierungssystem.Basisgrundplatzierung (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                                          BasisgrundExtern  => Basisgrund);
      
   end BasisgrundBestimmen;
   
   
   
   procedure ZusatzgrundBestimmen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
   is
      use type SystemDatentypen.NullBisHundert;
   begin
      
      Zahlenspeicher := 0;
      WelcherGrund := 0;
      
      ZufallszahlenSchleife:
      for ZufallszahlSchleifenwert in ZusatzWahrscheinlichkeitenArray'Range loop
         
         GezogeneZahl := ZufallsgeneratorenKartenLogik.KartengeneratorZufallswerte;
         
         if
           GezogeneZahl > ZusatzWahrscheinlichkeiten (ZufallszahlSchleifenwert)
           or
             GezogeneZahl = 0
         then
            null;
            
         elsif
           (GezogeneZahl = Zahlenspeicher
            and
              ZufallsgeneratorenHTB6.Münzwurf = True)
           or
             GezogeneZahl > Zahlenspeicher
         then
            Zahlenspeicher := GezogeneZahl;
            WelcherGrund := ZufallszahlSchleifenwert;
            
         else
            null;
         end if;
         
      end loop ZufallszahlenSchleife;
      
      Zusatzgrund := ZahlenNachZusatzgrund (WelcherGrund);
      
      case
        Zusatzgrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            return;
            
         when others =>
            Zusatzgrund := ZusatzExtraberechnungen (KoordinatenExtern => KoordinatenExtern,
                                                    GrundExtern       => Zusatzgrund);
      end case;
            
      case
        Zusatzgrund
      is
         when KartengrundDatentypen.Zusatzgrund_Oberfläche_Enum'Range =>
            Zusatzgrundplatzierungssystem.Zusatzgrundplatzierung (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                                                  ZusatzgrundExtern => Zusatzgrund);
            
         when others =>
            null;
      end case;
            
   end ZusatzgrundBestimmen;
   
   
   
   function BasisExtraberechnungen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum)
      return KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum
   is begin
     
      case
        GrundExtern
      is
         when KartengrundDatentypen.Basisgrund_Flachland_Enum'Range =>
            return ZusatzberechnungFlachland (KoordinatenExtern => KoordinatenExtern,
                                              GrundExtern       => GrundExtern);
            
         when KartengrundDatentypen.Basisgrund_Wüste_Enum'Range =>
            return ZusatzberechnungWüste (KoordinatenExtern => KoordinatenExtern,
                                           GrundExtern       => GrundExtern);
            
         when KartengrundDatentypen.Basisgrund_Tundra_Enum'Range =>
            return ZusatzberechnungTundra (KoordinatenExtern => KoordinatenExtern,
                                           GrundExtern       => GrundExtern);
                        
         when KartengrundDatentypen.Basisgrund_Hügel_Enum'Range =>
            return ZusatzberechnungHügel (KoordinatenExtern => KoordinatenExtern,
                                           GrundExtern       => GrundExtern);
            
         when KartengrundDatentypen.Basisgrund_Gebirge_Enum'Range =>
            return ZusatzberechnungGebirge (KoordinatenExtern => KoordinatenExtern,
                                            GrundExtern       => GrundExtern);
      end case;
   
   end BasisExtraberechnungen;
   
   
   
   function ZusatzExtraberechnungen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Zusatzgrund_Oberfläche_Enum)
      return KartengrundDatentypen.Zusatzgrund_Enum
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Zusatzgrund_Wald_Enum'Range =>
            return ZusatzberechnungWald (KoordinatenExtern => KoordinatenExtern,
                                         GrundExtern       => GrundExtern);
            
         when KartengrundDatentypen.Zusatzgrund_Dschungel_Enum'Range =>
            return ZusatzberechnungDschungel (KoordinatenExtern => KoordinatenExtern,
                                              GrundExtern       => GrundExtern);
            
         when KartengrundDatentypen.Zusatzgrund_Sumpf_Enum'Range =>
            return ZusatzberechnungSumpf (KoordinatenExtern => KoordinatenExtern,
                                          GrundExtern       => GrundExtern);
      end case;
   
   end ZusatzExtraberechnungen;
   
   
   
   function ZusatzberechnungTundra
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Tundra_Enum)
      return KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum
   is
      use type KartengrundDatentypen.Basisgrund_Enum;
   begin
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartenDatentypen.SenkrechteUmgebungEins'Range loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartenDatentypen.WaagerechteUmgebungEins'Range loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                                      TaskExtern        => SystemDatentypen.Logik_Task_Enum);
            
            if
              KartenWert.Waagerechte = KartenKonstanten.LeerWaagerechte
            then
               null;
               
            elsif
              LeseWeltkarte.Basisgrund (KoordinatenExtern => KartenWert) = KartengrundDatentypen.Wüste_Enum
            then
               return KartengrundDatentypen.Wüste_Enum;
                  
            else
               null;
            end if;
            
         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
      
      return GrundExtern;
      
   end ZusatzberechnungTundra;
   
   
   
   function ZusatzberechnungWüste
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Wüste_Enum)
      return KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum
   is
      use type KartengrundDatentypen.Basisgrund_Enum;
   begin
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartenDatentypen.SenkrechteUmgebungEins'Range loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartenDatentypen.WaagerechteUmgebungEins'Range loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                                      TaskExtern        => SystemDatentypen.Logik_Task_Enum);
            
            if
              KartenWert.Waagerechte = KartenKonstanten.LeerWaagerechte
            then
               null;
               
            elsif
              LeseWeltkarte.Basisgrund (KoordinatenExtern => KartenWert) = KartengrundDatentypen.Eis_Enum
              or
                LeseWeltkarte.Basisgrund (KoordinatenExtern => KartenWert) = KartengrundDatentypen.Tundra_Enum
            then
               return KartengrundDatentypen.Tundra_Enum;
                  
            else
               null;
            end if;
            
         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
      
      return GrundExtern;
      
   end ZusatzberechnungWüste;
   
   
   
   function ZusatzberechnungHügel
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Hügel_Enum)
      return KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum
   is begin
      
      if
        KoordinatenExtern.Senkrechte = KartenDatentypen.Senkrechte (KoordinatenExtern.Waagerechte)
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungHügel;
   
   
   
   function ZusatzberechnungGebirge
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Gebirge_Enum)
      return KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum
   is begin
      
      if
        KoordinatenExtern.Senkrechte = KartenDatentypen.Senkrechte (KoordinatenExtern.Waagerechte)
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungGebirge;
   
   
   
   function ZusatzberechnungFlachland
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Flachland_Enum)
      return KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum
   is begin
         
      if
        KoordinatenExtern.Senkrechte = KartenDatentypen.Senkrechte (KoordinatenExtern.Waagerechte)
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungFlachland;
   
   
   
   function ZusatzberechnungWald
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Zusatzgrund_Wald_Enum)
      return KartengrundDatentypen.Zusatzgrund_Enum
   is
      use type KartengrundDatentypen.Basisgrund_Enum;
   begin
      
      Basisgrund := LeseWeltkarte.Basisgrund (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte));
      
      if
        Basisgrund = KartengrundDatentypen.Wüste_Enum
      then
         return KartengrundDatentypen.Leer_Zusatzgrund_Enum;
         
      else
         return GrundExtern;
      end if;
      
   end ZusatzberechnungWald;
   
   
   
   function ZusatzberechnungDschungel
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Zusatzgrund_Dschungel_Enum)
      return KartengrundDatentypen.Zusatzgrund_Enum
   is
      use type KartengrundDatentypen.Basisgrund_Enum;
   begin
      
      Basisgrund := LeseWeltkarte.Basisgrund (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte));
      
      if
        Basisgrund = KartengrundDatentypen.Wüste_Enum
        or
          Basisgrund = KartengrundDatentypen.Tundra_Enum
      then
         return KartengrundDatentypen.Leer_Zusatzgrund_Enum;
         
      else
         return GrundExtern;
      end if;
            
   end ZusatzberechnungDschungel;
   
   
   
   function ZusatzberechnungSumpf
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Zusatzgrund_Sumpf_Enum)
      return KartengrundDatentypen.Zusatzgrund_Enum
   is
      use type KartengrundDatentypen.Basisgrund_Enum;
   begin
      
      Basisgrund := LeseWeltkarte.Basisgrund (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte));
      
      if
        Basisgrund = KartengrundDatentypen.Wüste_Enum
      then
         return KartengrundDatentypen.Leer_Zusatzgrund_Enum;
         
      else
         return GrundExtern;
      end if;
      
   end ZusatzberechnungSumpf;

end KartengeneratorLandschaftLogik;
