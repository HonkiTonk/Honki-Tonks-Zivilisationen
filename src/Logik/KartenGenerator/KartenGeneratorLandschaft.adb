pragma SPARK_Mode (On);

with KartenGrundKonstanten;
with KartenKonstanten;
with KartenRecordKonstanten;

with SchreibeKarten;
with LeseKarten;

with KartenGeneratorBerechnungenAllgemein; use KartenGeneratorBerechnungenAllgemein;
with ZufallGeneratorenKarten;
with KarteKoordinatenPruefen;

package body KartenGeneratorLandschaft is

   procedure GenerierungLandschaft
   is begin

      Karten.GeneratorKarte := (others => (others => KartenGrundKonstanten.LeerGrund));
      Karten.GeneratorGrund := (others => (others => False));
      
      AbstandEisschicht;
            
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) + KartenRecordKonstanten.Eisrand (Karten.Kartengröße)
        .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - KartenRecordKonstanten.Eisrand (Karten.Kartengröße) loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            if
              LeseKarten.Grund (KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert)) in KartenDatentypen.Karten_Grund_Wasser_Mit_Eis_Enum'Range
            then
               Karten.GeneratorGrund (YAchseSchleifenwert, XAchseSchleifenwert) := True;
               
            elsif
              Karten.GeneratorGrund (YAchseSchleifenwert, XAchseSchleifenwert) = True
            then
               null;

            else
               LandschaftBestimmen (KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert));
            end if;
                        
         end loop XAchseSchleife;
      end loop YAchseSchleife;
         
   end GenerierungLandschaft;
   
   
   
   procedure AbstandEisschicht
   is begin
      
      ObereEisschichtSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.WeltkarteArray'First (2) + KartenRecordKonstanten.Eisschild (Karten.Kartengröße) loop
         
         XAchseAbstandEisschicht (YAchseExtern => YAchseSchleifenwert);
         
      end loop ObereEisschichtSchleife;

      UntereEisschichtSchleife:
      for YAchseSchleifenwert in Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - KartenRecordKonstanten.Eisschild (Karten.Kartengröße) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
         
         XAchseAbstandEisschicht (YAchseExtern => YAchseSchleifenwert);
         
      end loop UntereEisschichtSchleife;
      
   end AbstandEisschicht;
   
   
   
   procedure XAchseAbstandEisschicht
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv)
   is begin
      
      EisschichtSchleife:
      for XAchseSchleifenwert in Karten.Weltkarte'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
         Karten.GeneratorKarte (YAchseExtern, XAchseSchleifenwert) := KartenDatentypen.Tundra;
            
      end loop EisschichtSchleife;
      
   end XAchseAbstandEisschicht;
   
   
   
   procedure LandschaftBestimmen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      GrundSchleife:
      for GrundSchleifenwert in KartenDatentypen.Karten_Grund_Generator_Enum'Range loop
         
         if
           GrundSchleifenwert = KartenDatentypen.Flachland
         then
            Karten.GeneratorGrund (KoordinatenExtern.YAchse, KoordinatenExtern.XAchse) := True;
            return;
            
         elsif
           GrundSchleifenwert = KartenDatentypen.Wüste
           and
             Karten.GeneratorKarte (KoordinatenExtern.YAchse, KoordinatenExtern.XAchse) = KartenDatentypen.Tundra
         then
            null;
            
         elsif
           GrundSchleifenwert = KartenDatentypen.Tundra
           and
             Karten.GeneratorKarte (KoordinatenExtern.YAchse, KoordinatenExtern.XAchse) = KartenDatentypen.Wüste
         then
            null;
            
         elsif
           GrundFestlegen (KoordinatenExtern => KoordinatenExtern,
                           GrundExtern       => GrundSchleifenwert)
           = True
         then
            return;
                  
         else
            null;
         end if;
         
      end loop GrundSchleife;
      
   end LandschaftBestimmen;
   
   
   
   function GrundFestlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      GrundExtern : in KartenDatentypen.Karten_Grund_Generator_Enum)
      return Boolean
   is begin
      
      AnzahlGleicherGrund := KartenGeneratorBerechnungenAllgemein.GleicherGrundAnzahlBestimmen (KoordinatenExtern => KoordinatenExtern,
                                                                                                GrundExtern       => GrundExtern,
                                                                                                EbeneExtern       => 0);
      
      if
        ZufallGeneratorenKarten.ZufälligerWert <= KartengrundWahrscheinlichkeiten (Karten.Kartentemperatur, GrundExtern, AnzahlGleicherGrund)
      then
         SchreibeKarten.Grund (KoordinatenExtern => KoordinatenExtern,
                               GrundExtern       => GrundExtern);
         Karten.GeneratorGrund (KoordinatenExtern.YAchse, KoordinatenExtern.XAchse) := True;
               
         case
           GrundExtern
         is
            when KartenDatentypen.Wüste | KartenDatentypen.Tundra =>
               AbstandTundraWüste (GrundExtern       => GrundExtern,
                                   KoordinatenExtern => KoordinatenExtern);
                     
            when others =>
               null;
         end case;
               
         case
           GrundExtern
         is
            when KartenDatentypen.Gebirge | KartenDatentypen.Hügel =>
               null;
                     
            when others =>
               WeitereHügel (KoordinatenExtern => KoordinatenExtern);
         end case;
               
         return True;
               
      else
         return False;
      end if;
      
   end GrundFestlegen;
   
   
   
   procedure AbstandTundraWüste
     (GrundExtern : in KartenDatentypen.Karten_Grund_Generator_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichZwei'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichZwei'Range loop

            KartenWertAbstand := KarteKoordinatenPruefen.KarteKoordinatenPrüfen (KoordinatenExtern => KoordinatenExtern,
                                                                                  ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                  LogikGrafikExtern => True);
            
            if
              KartenWertAbstand.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              Karten.GeneratorKarte (KartenWertAbstand.YAchse, KartenWertAbstand.XAchse) /= KartenGrundKonstanten.LeerGrund
            then
               null;
               
            else
               Karten.GeneratorKarte (KartenWertAbstand.YAchse, KartenWertAbstand.XAchse) := GrundExtern;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end AbstandTundraWüste;
   
   
   
   procedure WeitereHügel
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      AnzahlGleicherGrund := KartenGeneratorBerechnungenAllgemein.GleicherGrundAnzahlBestimmen (KoordinatenExtern => KoordinatenExtern,
                                                                                                GrundExtern       => KartenDatentypen.Gebirge,
                                                                                                EbeneExtern       => 0)
        + KartenGeneratorBerechnungenAllgemein.GleicherGrundAnzahlBestimmen (KoordinatenExtern => KoordinatenExtern,
                                                                             GrundExtern       => KartenDatentypen.Hügel,
                                                                             EbeneExtern       => 0);
      
      if
        ZufallGeneratorenKarten.ZufälligerWert <= ZusatzHügel (AnzahlGleicherGrund)
      then
         SchreibeKarten.Hügel (KoordinatenExtern => KoordinatenExtern,
                                HügelExtern       => True);
         
      else
         null;
      end if;
      
   end WeitereHügel;

end KartenGeneratorLandschaft;
