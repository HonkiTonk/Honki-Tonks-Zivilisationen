pragma SPARK_Mode (On);

with KartenKonstanten;

with SchreibeKarten;
with LeseKarten;

with ZufallGeneratorenKarten, KartePositionPruefen;

package body KartenGeneratorLandschaft is

   procedure GenerierungLandschaft
   is begin

      Karten.GeneratorKarte := (others => (others => KartenDatentypen.Leer));
      Karten.GeneratorGrund := (others => (others => False));
      
      AbstandEisschicht;
            
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) + KartenKonstanten.Eisrand (Karten.Kartengröße)
        .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - KartenKonstanten.Eisrand (Karten.Kartengröße) loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            if
              LeseKarten.Grund (PositionExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert)) in KartenDatentypen.Karten_Grund_Wasser_Mit_Eis_Enum'Range
            then
               Karten.GeneratorGrund (YAchseSchleifenwert, XAchseSchleifenwert) := True;
               
            elsif
              Karten.GeneratorGrund (YAchseSchleifenwert, XAchseSchleifenwert) = True
            then
               null;

            else
               LandschaftBestimmen (PositionExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert));
            end if;
                        
         end loop XAchseSchleife;
      end loop YAchseSchleife;
         
   end GenerierungLandschaft;
   
   
   
   procedure AbstandEisschicht
   is begin
      
      ObereEisschichtSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.WeltkarteArray'First (2) + KartenKonstanten.Eisschild (Karten.Kartengröße) loop
         
         XAchseAbstandEisschicht (YAchseExtern => YAchseSchleifenwert);
         
      end loop ObereEisschichtSchleife;

      UntereEisschichtSchleife:
      for YAchseSchleifenwert in Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - KartenKonstanten.Eisschild (Karten.Kartengröße) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
         
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
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      GrundSchleife:
      for GrundSchleifenwert in KartenDatentypen.Karten_Grund_Generator_Enum'Range loop
         
         if
           GrundSchleifenwert = KartenDatentypen.Flachland
         then
            Karten.GeneratorGrund (PositionExtern.YAchse, PositionExtern.XAchse) := True;
            return;
            
         elsif
           GrundSchleifenwert = KartenDatentypen.Wüste
           and
             Karten.GeneratorKarte (PositionExtern.YAchse, PositionExtern.XAchse) = KartenDatentypen.Tundra
         then
            null;
            
         elsif
           GrundSchleifenwert = KartenDatentypen.Tundra
           and
             Karten.GeneratorKarte (PositionExtern.YAchse, PositionExtern.XAchse) = KartenDatentypen.Wüste
         then
            null;
            
         elsif
           GrundFestlegen (PositionExtern => PositionExtern,
                           GrundExtern    => GrundSchleifenwert)
           = True
         then
            return;
                  
         else
            null;
         end if;
         
      end loop GrundSchleife;
      
   end LandschaftBestimmen;
   
   
   
   function GrundFestlegen
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      GrundExtern : in KartenDatentypen.Karten_Grund_Generator_Enum)
      return Boolean
   is begin
      
      AnzahlGleicherGrund := KartenGeneratorBerechnungenAllgemein.GleicherGrundAnzahlBestimmen (PositionExtern => PositionExtern,
                                                                                                GrundExtern    => GrundExtern,
                                                                                                EbeneExtern    => 0);
      
      if
        ZufallGeneratorenKarten.ZufälligerWert <= KartengrundWahrscheinlichkeiten (Karten.Kartentemperatur, GrundExtern, AnzahlGleicherGrund)
      then
         SchreibeKarten.Grund (PositionExtern => PositionExtern,
                               GrundExtern    => GrundExtern);
         Karten.GeneratorGrund (PositionExtern.YAchse, PositionExtern.XAchse) := True;
               
         case
           GrundExtern
         is
            when KartenDatentypen.Wüste | KartenDatentypen.Tundra =>
               AbstandTundraWüste (GrundExtern    => GrundExtern,
                                    PositionExtern => PositionExtern);
                     
            when others =>
               null;
         end case;
               
         case
           GrundExtern
         is
            when KartenDatentypen.Gebirge | KartenDatentypen.Hügel =>
               null;
                     
            when others =>
               WeitereHügel (PositionExtern => PositionExtern);
         end case;
               
         return True;
               
      else
         return False;
      end if;
      
   end GrundFestlegen;
   
   
   
   procedure AbstandTundraWüste
     (GrundExtern : in KartenDatentypen.Karten_Grund_Generator_Enum;
      PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.LoopRangeMinusZweiZuZwei'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.LoopRangeMinusZweiZuZwei'Range loop

            KartenWertAbstand := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => PositionExtern,
                                                                               ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert));
            
            if
              KartenWertAbstand.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              Karten.GeneratorKarte (KartenWertAbstand.YAchse, KartenWertAbstand.XAchse) /= KartenDatentypen.Leer
            then
               null;
               
            else
               Karten.GeneratorKarte (KartenWertAbstand.YAchse, KartenWertAbstand.XAchse) := GrundExtern;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end AbstandTundraWüste;
   
   
   
   procedure WeitereHügel
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      AnzahlGleicherGrund := KartenGeneratorBerechnungenAllgemein.GleicherGrundAnzahlBestimmen (PositionExtern => PositionExtern,
                                                                                                GrundExtern    => KartenDatentypen.Gebirge,
                                                                                                EbeneExtern    => 0)
        + KartenGeneratorBerechnungenAllgemein.GleicherGrundAnzahlBestimmen (PositionExtern => PositionExtern,
                                                                             GrundExtern    => KartenDatentypen.Hügel,
                                                                             EbeneExtern    => 0);
      
      if
        ZufallGeneratorenKarten.ZufälligerWert <= ZusatzHügel (AnzahlGleicherGrund)
      then
         SchreibeKarten.Hügel (PositionExtern => PositionExtern,
                                HügelExtern   => True);
         
      else
         null;
      end if;
      
   end WeitereHügel;

end KartenGeneratorLandschaft;
