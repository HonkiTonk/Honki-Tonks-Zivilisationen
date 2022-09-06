function Textdarstellung
  (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
   ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
   AktuelleAuswahlExtern : in Integer)
      return Sf.System.Vector2.sfVector2f
is begin

   Rechenwert.y := TextberechnungenHoeheGrafik.Zeilenabstand;
   Textbreite := 0.00;

   PositionenSchleife:
   for PositionSchleifenwert in Textarrayanpassung .. SystemKonstanten.EndeAbzugGrafik (WelchesMenüExtern) loop

      FarbeFestlegen (WelchesMenüExtern     => WelchesMenüExtern,
                      AktuelleAuswahlExtern => AktuelleAuswahlExtern + 1,
                      AktuellerTextExtern   => PositionSchleifenwert);

      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.MenüsSFMLAccess (WelchesMenüExtern, PositionSchleifenwert),
                                         str  => MenuestringsSetzenGrafik.MenüstringsSetzen (WelcheZeileExtern => PositionSchleifenwert,
                                                                                              WelchesMenüExtern => WelchesMenüExtern));

      Rechenwert.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.MenüsSFMLAccess (WelchesMenüExtern, PositionSchleifenwert),
                                                                            ViewbreiteExtern => ViewflächeExtern.x);

      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.MenüsSFMLAccess (WelchesMenüExtern, PositionSchleifenwert),
                                    position => Rechenwert);

      Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.MenüsSFMLAccess (WelchesMenüExtern, PositionSchleifenwert),
                                                                          TextbreiteExtern => Textbreite);

      InteraktionAuswahl.PositionenMenüeinträge (WelchesMenüExtern, PositionSchleifenwert - 1)
        := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.MenüsSFMLAccess (WelchesMenüExtern, PositionSchleifenwert));

      Rechenwert.y := Rechenwert.y + TextberechnungenHoeheGrafik.Zeilenabstand;

      Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                         text         => TextaccessVariablen.MenüsSFMLAccess (WelchesMenüExtern, PositionSchleifenwert));

   end loop PositionenSchleife;

   return (Textbreite, Rechenwert.y);

end Textdarstellung;
