function Gebäude
  (AuswahlExtern : in StadtDatentypen.GebäudeID;
   SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
   BauenVerkaufenExtern : in Boolean)
      return Float
is begin

   Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstand;
   Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstand;

   GebäudeSchleife:
   for GebäudeSchleifenwert in StadtDatentypen.GebäudeIDVorhanden'Range loop

      case
        InteraktionAuswahl.MöglicheGebäude (GebäudeSchleifenwert)
      is
         when True =>
            Textposition.y := TextaccessverwaltungssystemErweitertGrafik.SkalierenFarbeZeichnen (TextpositionExtern       => Textposition,
                                                                                                 MaximaleTextbreiteExtern => ViewflächeBauliste.x,
                                                                                                 TextAccessExtern         => TextaccessVariablen.GebäudetextAccess (SpeziesExtern, GebäudeSchleifenwert),
                                                                                                 FarbeExtern              => TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => Positive (GebäudeSchleifenwert),
                                                                                                                                                                    AuswahlExtern    => Natural (AuswahlExtern)));

            InteraktionAuswahl.PositionenGebäudeBauen (GebäudeSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.GebäudetextAccess (SpeziesExtern, GebäudeSchleifenwert));

         when False =>
            null;
      end case;

   end loop GebäudeSchleife;

   Textposition.y := Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstand;

   BauauswahlGebaeudeGrafik.Informationen (AuswahlExtern        => AuswahlExtern,
                                           SpeziesExtern        => SpeziesExtern,
                                           BauenVerkaufenExtern => BauenVerkaufenExtern);

   return Textposition.y;

end Gebäude;
