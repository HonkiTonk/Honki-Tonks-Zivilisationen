DIE ADS IST IM KARTENFORMMERKBLATT!!!!!

pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenGrundDatentypen; use KartenGrundDatentypen;
with KartenKonstanten;
with KartenRecordKonstanten;

with SchreibeKarten;
with LeseKarten;

with KartenGeneratorBerechnungenAllgemein; use KartenGeneratorBerechnungenAllgemein;
with ZufallsgeneratorenKarten;
with Kartenkoordinatenberechnungssystem;
with KartengeneratorVariablen;

package body KartenGeneratorLandschaft is

   procedure GenerierungLandschaft
   is begin
      case
        Karten.Kartenparameter.Kartenart
      is
         when KartenDatentypen.Kartenart_Chaotisch_Enum'Range =>
            return;

         when others =>
            null;
      end case;

      KartengeneratorVariablen.GeneratorKarte := (others => (others => KartenGrundDatentypen.Leer_Grund_Enum));
      KartengeneratorVariablen.GeneratorGrund := (others => (others => False));

      AbstandEisschicht;

      YAchseSchleife:
      for YAchseSchleifenwert in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.YAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.XAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.XAchse loop

            if
              LeseKarten.Grund (KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert)) in KartenGrundDatentypen.Karten_Grund_Wasser_Mit_Eis_Enum'Range
            then
               KartengeneratorVariablen.GeneratorGrund (YAchseSchleifenwert, XAchseSchleifenwert) := True;

            elsif
              KartengeneratorVariablen.GeneratorGrund (YAchseSchleifenwert, XAchseSchleifenwert) = True
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
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.WeltkarteArray'First (2) + KartenRecordKonstanten.Eisschild (Karten.Kartenparameter.Kartengröße, KartenDatentypen.Norden_Enum) loop

         XAchseAbstandEisschicht (YAchseExtern => YAchseSchleifenwert);

      end loop ObereEisschichtSchleife;

      UntereEisschichtSchleife:
      for YAchseSchleifenwert in Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse - KartenRecordKonstanten.Eisschild (Karten.Kartenparameter.Kartengröße, KartenDatentypen.Süden_Enum)
        .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse loop

         XAchseAbstandEisschicht (YAchseExtern => YAchseSchleifenwert);

      end loop UntereEisschichtSchleife;

   end AbstandEisschicht;



   procedure XAchseAbstandEisschicht
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv)
   is begin

      EisschichtSchleife:
      for XAchseSchleifenwert in Karten.Weltkarte'First (3) .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse loop

         KartengeneratorVariablen.GeneratorKarte (YAchseExtern, XAchseSchleifenwert) := KartenGrundDatentypen.Tundra_Enum;

      end loop EisschichtSchleife;

   end XAchseAbstandEisschicht;



   procedure LandschaftBestimmen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin

      GrundSchleife:
      for GrundSchleifenwert in KartenGrundDatentypen.Karten_Grund_Generator_Enum'Range loop

         if
           GrundSchleifenwert = KartenGrundDatentypen.Flachland_Enum
         then
            KartengeneratorVariablen.GeneratorGrund (KoordinatenExtern.YAchse, KoordinatenExtern.XAchse) := True;
            return;

         elsif
           GrundSchleifenwert = KartenGrundDatentypen.Wüste_Enum
           and
             KartengeneratorVariablen.GeneratorKarte (KoordinatenExtern.YAchse, KoordinatenExtern.XAchse) = KartenGrundDatentypen.Tundra_Enum
         then
            null;

         elsif
           GrundSchleifenwert = KartenGrundDatentypen.Tundra_Enum
           and
             KartengeneratorVariablen.GeneratorKarte (KoordinatenExtern.YAchse, KoordinatenExtern.XAchse) = KartenGrundDatentypen.Wüste_Enum
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
      GrundExtern : in KartenGrundDatentypen.Karten_Grund_Generator_Enum)
      return Boolean
   is begin

      AnzahlGleicherGrund := KartenGeneratorBerechnungenAllgemein.GleicherGrundAnzahlBestimmen (KoordinatenExtern => KoordinatenExtern,
                                                                                                GrundExtern       => GrundExtern,
                                                                                                EbeneExtern       => 0);

      if
        ZufallsgeneratorenKarten.ZufälligerWert <= KartengrundWahrscheinlichkeiten (Karten.Kartenparameter.Kartentemperatur, GrundExtern, AnzahlGleicherGrund)
      then
         SchreibeKarten.Grund (KoordinatenExtern => KoordinatenExtern,
                               GrundExtern       => GrundExtern);
         KartengeneratorVariablen.GeneratorGrund (KoordinatenExtern.YAchse, KoordinatenExtern.XAchse) := True;

         case
           GrundExtern
         is
            when KartenGrundDatentypen.Wüste_Enum | KartenGrundDatentypen.Tundra_Enum =>
               AbstandTundraWüste (GrundExtern       => GrundExtern,
                                    KoordinatenExtern => KoordinatenExtern);

            when others =>
               null;
         end case;

         case
           GrundExtern
         is
            when KartenGrundDatentypen.Gebirge_Enum | KartenGrundDatentypen.Hügel_Enum =>
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
     (GrundExtern : in KartenGrundDatentypen.Karten_Grund_Generator_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin

      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichZwei'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichZwei'Range loop

            KartenWertAbstand := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                        ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                        LogikGrafikExtern => True);

            if
              KartenWertAbstand.XAchse = KartenKonstanten.LeerXAchse
            then
               null;

            elsif
              KartengeneratorVariablen.GeneratorKarte (KartenWertAbstand.YAchse, KartenWertAbstand.XAchse) /= KartenGrundDatentypen.Leer_Grund_Enum
            then
               null;

            else
               KartengeneratorVariablen.GeneratorKarte (KartenWertAbstand.YAchse, KartenWertAbstand.XAchse) := GrundExtern;
            end if;

         end loop XAchseSchleife;
      end loop YAchseSchleife;

   end AbstandTundraWüste;



   procedure WeitereHügel
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin

      AnzahlGleicherGrund := KartenGeneratorBerechnungenAllgemein.GleicherGrundAnzahlBestimmen (KoordinatenExtern => KoordinatenExtern,
                                                                                                GrundExtern       => KartenGrundDatentypen.Gebirge_Enum,
                                                                                                EbeneExtern       => 0)
        + KartenGeneratorBerechnungenAllgemein.GleicherGrundAnzahlBestimmen (KoordinatenExtern => KoordinatenExtern,
                                                                             GrundExtern       => KartenGrundDatentypen.Hügel_Enum,
                                                                             EbeneExtern       => 0);

      if
        ZufallsgeneratorenKarten.ZufälligerWert <= ZusatzHügel (AnzahlGleicherGrund)
      then
         SchreibeKarten.Hügel (KoordinatenExtern => KoordinatenExtern,
                                HügelExtern       => True);

      else
         null;
      end if;

   end WeitereHügel;

end KartenGeneratorLandschaft;



procedure AnzeigeSpracheKonsole;
-- (AktuelleAuswahlExtern : in Positive;
--  LetzteZeileExtern : in Positive);

procedure AnzeigeSpracheKonsole
is begin

   Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");

   --  LängsterText := 1;

   --  TextlängePrüfenSchleife:
   --  for ZeilenSchleifenwert in AktuelleSprachenArray'First .. LetzteZeileExtern loop

   --     if
   --      To_Wide_Wide_String (Source => AktuelleSprachen (ZeilenSchleifenwert))'Length > LängsterText
   --    then
   --       LängsterText := To_Wide_Wide_String (Source => AktuelleSprachen (ZeilenSchleifenwert))'Length;

   --    else
   --       null;
   --    end if;

   --  end loop TextlängePrüfenSchleife;

   -- AnzeigeSchleife:
   --  for ZeileSchleifenwert in AktuelleSprachenArray'First .. LetzteZeileExtern loop

   --     if
   --       AktuelleAuswahlExtern = ZeileSchleifenwert
   --     then
   --       RahmenTeilEinsSchleife:
   --       for TextlängeEins in 1 .. LängsterText loop

   --        if
   --          TextlängeEins = 1
   --       then
   Put (Item => "╔");
   Put (Item => "═");

   --       elsif
   --        TextlängeEins = LängsterText
   --      then
   Put (Item => "═");
   Put_Line (Item => "╗");
   Put (Item => "║");
   --         Put (Item => To_Wide_Wide_String (Source => AktuelleSprachen (ZeileSchleifenwert)));

   --         LeererPlatzSchleife:
   --         for LeererPlatz in 1 .. LängsterText - To_Wide_Wide_String (Source => AktuelleSprachen (ZeileSchleifenwert))'Length loop

   Put (Item => " ");

   --        end loop LeererPlatzSchleife;

   Put_Line (Item => "║");
   Put (Item => "╚");

   --      else
   Put (Item => "═");
   --     end if;

   --  end loop RahmenTeilEinsSchleife;

   --  RahmenTeilZweiSchleife:
   --  for TextlängeZweiSchleifenwert in 1 .. LängsterText loop

   --    if
   --      TextlängeZweiSchleifenwert = LängsterText
   --    then
   Put (Item => "═");
   Put_Line (Item => "╝");

   --    else
   Put (Item => "═");
   --    end if;

   --  end loop RahmenTeilZweiSchleife;

   -- else
   --     Put_Line (Item => To_Wide_Wide_String (Source => AktuelleSprachen (ZeileSchleifenwert)));
   --  end if;

   --  end loop AnzeigeSchleife;

end AnzeigeSpracheKonsole;
