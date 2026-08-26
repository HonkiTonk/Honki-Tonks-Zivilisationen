-- Wäre das so sinnvoller als das bisherige System? äöü
ViewbereichBeschreibung.Viewbereich := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => ViewbereichBeschreibung.Viewbereich,
                                                                                          VerhältnisExtern => (GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüBeschreibung).width,
                                                                                                                GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüBeschreibung).height));

if
  ViewbereichBeschreibung.Viewbereich /= ViewbereichBeschreibung.ViewbereichAlt
then
   ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.BauviewAccesse (ViewKonstanten.BaumenüBeschreibung),
                                         GrößeExtern          => ViewbereichBeschreibung.Viewbereich,
                                         AnzeigebereichExtern => GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüBeschreibung));

   ViewbereichBeschreibung.ViewbereichAlt := ViewbereichBeschreibung.Viewbereich;

else
   ViewsEinstellenGrafik.ViewSetzen (ViewExtern => Views.BauviewAccesse (ViewKonstanten.BaumenüBeschreibung));
end if;

HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                               AbmessungenExtern => ViewbereichBeschreibung.Viewbereich);
-- Wird das ober drüber noch gebraucht, ist das noch sinnvoll? äöü






   function SichtbarkeitEinByte
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      VorhandeneSpeziesExtern : in SpeziesDatentypen.SpeziesnummernVorhanden;
      LadenPrüfenExtern : in Boolean)
      return Boolean
   is
      use type SystemDatentypenHTSEB.EinByte;
   begin

      GesamteSichtbarkeit := (others => False);
      Potenz := (VorhandeneSpeziesExtern - 1);

      SystemDatentypenHTSEB.EinByte'Read (Stream (File => DateiLadenExtern),
                                          SichtbarkeitVorhanden);

      SichtbarkeitSchleife:
      for SichtbarkeitSchleifenwert in reverse SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop

         case
           SpielstandAllgemeinesLogik.SpeziesbelegungLesen (SpeziesExtern => SichtbarkeitSchleifenwert)
         is
            when SpeziesDatentypen.Spieler_Belegt_Enum'Range =>
               if
                 SichtbarkeitVorhanden >= 2**Potenz
               then
                  GesamteSichtbarkeit (SichtbarkeitSchleifenwert) := True;
                  SichtbarkeitVorhanden := SichtbarkeitVorhanden - 2**Potenz;

               else
                  null;
               end if;

               Potenz := Potenz - 1;

            when SpeziesDatentypen.Leer_Spieler_Enum =>
               null;
         end case;

      end loop SichtbarkeitSchleife;

      case
        LadenPrüfenExtern
      is
         when True =>
            SchreibeWeltkarte.GesamteSichtbarkeit (KoordinatenExtern  => KoordinatenExtern,
                                                   SichtbarkeitExtern => GesamteSichtbarkeit);

         when False =>
            null;
      end case;

      return True;

   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenSichtbarkeitLogik.SichtbarkeitEinByte: Konnte nicht geladen werden: LadenPrüfenExtern = " & LadenPrüfenExtern'Wide_Wide_Image & " "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;

   end SichtbarkeitEinByte;
