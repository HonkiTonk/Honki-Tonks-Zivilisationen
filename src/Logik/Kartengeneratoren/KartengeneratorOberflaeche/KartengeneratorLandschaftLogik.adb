with ZufallsgeneratorenHTSEB;

with LadezeitenDatentypen;
with KartenKonstanten;
with SystemDatentypen;

with LeseWeltkarte;

with ZufallsgeneratorenKartenLogik;
with KartenkoordinatenberechnungssystemLogik;
with KartengeneratorVariablenLogik;
with LadezeitenLogik;
with Basisgrundplatzierungssystem;
with KartengeneratorZusatzlandschaftLogik;

package body KartengeneratorLandschaftLogik is

   procedure GenerierungLandschaft
   is begin
      
      Schleifenbereiche := KartengeneratorVariablenLogik.PolfreierBereichLesen;
      
      LadezeitBasis := 100.00 / Float (Schleifenbereiche.MaximaleSenkrechte);
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in Schleifenbereiche.MinimaleSenkrechte .. Schleifenbereiche.MaximaleSenkrechte loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in Schleifenbereiche.MinimaleWaagerechte .. Schleifenbereiche.MaximaleWaagerechte loop
            
            case
              LeseWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert))
            is
               when KartenbasisgrundDatentypen.Grasland_Enum =>
                  BasisgrundBestimmen (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert));

               when others =>
                  null;
            end case;
            
            case
              LeseWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert))
            is
               when KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum'Range | KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Wasser_Enum'Range =>
                  KartengeneratorZusatzlandschaftLogik.ZusatzgrundBestimmen (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert));

               when others =>
                  null;
            end case;
            
         end loop WaagerechteSchleife;
         
         LadezeitenLogik.KartengeneratorSchreiben (BerechnungszeitExtern => LadezeitenDatentypen.Generiere_Landschaft_Enum,
                                                   ZeitExtern            => LadezeitBasis);
         
      end loop SenkrechteSchleife;
      
   end GenerierungLandschaft;
   
   
   
   procedure BasisgrundBestimmen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
   is
      use type SystemDatentypenHTSEB.NullBisHundert;
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
                 ZufallsgeneratorenHTSEB.Münzwurf = True)
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
   
   
   
   function BasisExtraberechnungen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum)
      return KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum
   is begin
     
      case
        GrundExtern
      is
         when KartenbasisgrundDatentypen.Basisgrund_Grasland_Enum'Range | KartenbasisgrundDatentypen.Basisgrund_Steppe_Enum'Range =>
            return ZusatzberechnungGrasland (KoordinatenExtern => KoordinatenExtern,
                                              GrundExtern       => GrundExtern);
            
         when KartenbasisgrundDatentypen.Basisgrund_Wüste_Enum'Range | KartenbasisgrundDatentypen.Basisgrund_Savanne_Enum'Range =>
            return ZusatzberechnungWüste (KoordinatenExtern => KoordinatenExtern,
                                           GrundExtern       => GrundExtern);
            
         when KartenbasisgrundDatentypen.Basisgrund_Tundra_Enum'Range | KartenbasisgrundDatentypen.Basisgrund_Arktisch_Enum'Range =>
            return ZusatzberechnungTundra (KoordinatenExtern => KoordinatenExtern,
                                           GrundExtern       => GrundExtern);
                        
         when KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Range =>
            return ZusatzberechnungHügel (KoordinatenExtern => KoordinatenExtern,
                                           GrundExtern       => GrundExtern);
            
         when KartenbasisgrundDatentypen.Basisgrund_Gebirge_Enum'Range =>
            return ZusatzberechnungGebirge (KoordinatenExtern => KoordinatenExtern,
                                            GrundExtern       => GrundExtern);
      end case;
   
   end BasisExtraberechnungen;
   
   
   
   function ZusatzberechnungTundra
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum)
      return KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum
   is
      use type KartenbasisgrundDatentypen.Basisgrund_Enum;
   begin
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartenDatentypen.SenkrechteUmgebungEins'Range loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartenDatentypen.WaagerechteUmgebungEins'Range loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Koordinatenberechnung (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                                                                         ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                         TaskExtern        => SystemDatentypen.Logik_Task_Enum);
            
            if
              KartenWert.Waagerechte = KartenKonstanten.LeerWaagerechte
            then
               null;
               
            elsif
              LeseWeltkarte.Basisgrund (KoordinatenExtern => KartenWert) = KartenbasisgrundDatentypen.Wüste_Enum
            then
               return KartenbasisgrundDatentypen.Wüste_Enum;
                  
            else
               null;
            end if;
            
         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
      
      return GrundExtern;
      
   end ZusatzberechnungTundra;
   
   
   
   function ZusatzberechnungWüste
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum)
      return KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum
   is
      use type KartenbasisgrundDatentypen.Basisgrund_Enum;
   begin
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartenDatentypen.SenkrechteUmgebungEins'Range loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartenDatentypen.WaagerechteUmgebungEins'Range loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Koordinatenberechnung (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                                                                         ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                         TaskExtern        => SystemDatentypen.Logik_Task_Enum);
            
            if
              KartenWert.Waagerechte = KartenKonstanten.LeerWaagerechte
            then
               null;
               
            elsif
              LeseWeltkarte.Basisgrund (KoordinatenExtern => KartenWert) = KartenbasisgrundDatentypen.Eis_Enum
              or
                LeseWeltkarte.Basisgrund (KoordinatenExtern => KartenWert) = KartenbasisgrundDatentypen.Tundra_Enum
            then
               return KartenbasisgrundDatentypen.Tundra_Enum;
                  
            else
               null;
            end if;
            
         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
      
      return GrundExtern;
      
   end ZusatzberechnungWüste;
   
   
   
   function ZusatzberechnungHügel
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum)
      return KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum
   is begin
      
      if
        KoordinatenExtern.Senkrechte = KartenDatentypen.SenkrechteBasis (KoordinatenExtern.Waagerechte)
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungHügel;
   
   
   
   function ZusatzberechnungGebirge
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Gebirge_Enum)
      return KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum
   is begin
      
      if
        KoordinatenExtern.Senkrechte = KartenDatentypen.SenkrechteBasis (KoordinatenExtern.Waagerechte)
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungGebirge;
   
   
   
   function ZusatzberechnungGrasland
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum)
      return KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum
   is begin
         
      if
        KoordinatenExtern.Senkrechte = KartenDatentypen.SenkrechteBasis (KoordinatenExtern.Waagerechte)
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungGrasland;

end KartengeneratorLandschaftLogik;
