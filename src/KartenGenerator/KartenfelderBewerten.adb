pragma SPARK_Mode (On);

with GlobaleKonstanten, GlobaleDatentypen;
use GlobaleDatentypen;

with Karten, FelderwerteFestlegen;

package body KartenfelderBewerten is

   procedure KartenfelderBewerten
   is

      task UnterwasserUnterirdischObenLinks;
      task UnterwasserUnterirdischObenRechts;
      task UnterwasserUnterirdischUntenLinks;
      task UnterwasserUnterirdischUntenRechts;
      task PlanetenInneresObenLinks;
      task PlanetenInneresObenRechts;      
      task PlanetenInneresUntenLinks;      
      task PlanetenInneresUntenRechts;
      task StandardObenRechts;
      task StandardUntenLinks;
      task StandardUntenRechts;
      
      task body UnterwasserUnterirdischObenLinks
      is begin
         
         YAchseUnterwasserSchleife:
         for YAchseUnterwasserSchleifenwert in Karten.WeltkarteArray'First (2) + GlobaleKonstanten.Eisrand .. (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisrand) / 2 loop
            XAchseUnterwasserSchleife:
            for XAchseUnterwasserSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / 2 loop
               
               FelderwerteFestlegen.KartenfelderBewerten (GenerierungExtern => True,
                                                          KoordinatenExtern => (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert));
               
            end loop XAchseUnterwasserSchleife;
         end loop YAchseUnterwasserSchleife;
         
      end UnterwasserUnterirdischObenLinks;
      
      
      
      task body UnterwasserUnterirdischObenRechts
      is begin
         
         YAchseUnterwasserSchleife:
         for YAchseUnterwasserSchleifenwert in Karten.WeltkarteArray'First (2) + GlobaleKonstanten.Eisrand .. (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisrand) / 2 loop
            XAchseUnterwasserSchleife:
            for XAchseUnterwasserSchleifenwert in Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / 2 + 1 .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
               
               FelderwerteFestlegen.KartenfelderBewerten (GenerierungExtern => True,
                                                          KoordinatenExtern => (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert));
               
            end loop XAchseUnterwasserSchleife;
         end loop YAchseUnterwasserSchleife;
         
      end UnterwasserUnterirdischObenRechts;
      
      
      
      task body UnterwasserUnterirdischUntenLinks
      is begin
         
         YAchseUnterwasserSchleife:
         for YAchseUnterwasserSchleifenwert in (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisrand) / 2 + 1 .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisrand loop
            XAchseUnterwasserSchleife:
            for XAchseUnterwasserSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / 2 loop
               
               FelderwerteFestlegen.KartenfelderBewerten (GenerierungExtern => True,
                                                          KoordinatenExtern => (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert));
               
            end loop XAchseUnterwasserSchleife;
         end loop YAchseUnterwasserSchleife;
         
      end UnterwasserUnterirdischUntenLinks;
      
      
      
      task body UnterwasserUnterirdischUntenRechts
      is begin
         
         YAchseUnterwasserSchleife:
         for YAchseUnterwasserSchleifenwert in (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisrand) / 2 + 1 .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisrand loop
            XAchseUnterwasserSchleife:
            for XAchseUnterwasserSchleifenwert in Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / 2 + 1 .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
               
               FelderwerteFestlegen.KartenfelderBewerten (GenerierungExtern => True,
                                                          KoordinatenExtern => (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert));
               
            end loop XAchseUnterwasserSchleife;
         end loop YAchseUnterwasserSchleife;
         
      end UnterwasserUnterirdischUntenRechts;
      
      
      
      task body PlanetenInneresObenLinks
      is begin
         
         YAchseInneresSchleife:
         for YAchseInneresSchleifenwert in Karten.WeltkarteArray'First (2) + GlobaleKonstanten.Eisrand .. (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisrand) / 2 loop
            XAchseInneresSchleife:
            for XAchseInneresSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / 2 loop
               
               FelderwerteFestlegen.KartenfelderBewerten (GenerierungExtern => True,
                                                          KoordinatenExtern => (-2, YAchseInneresSchleifenwert, XAchseInneresSchleifenwert));
               
            end loop XAchseInneresSchleife;
         end loop YAchseInneresSchleife;
         
      end PlanetenInneresObenLinks;
      
      
      
      task body PlanetenInneresObenRechts
      is begin
         
         YAchseInneresSchleife:
         for YAchseInneresSchleifenwert in Karten.WeltkarteArray'First (2) + GlobaleKonstanten.Eisrand .. (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisrand) / 2 loop
            XAchseInneresSchleife:
            for XAchseInneresSchleifenwert in Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / 2 + 1 .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
               
               FelderwerteFestlegen.KartenfelderBewerten (GenerierungExtern => True,
                                                          KoordinatenExtern => (-2, YAchseInneresSchleifenwert, XAchseInneresSchleifenwert));
               
            end loop XAchseInneresSchleife;
         end loop YAchseInneresSchleife;
         
      end PlanetenInneresObenRechts;
      
      
      
      task body PlanetenInneresUntenLinks
      is begin
         
         YAchseInneresSchleife:
         for YAchseInneresSchleifenwert in (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisrand) / 2 + 1 .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisrand loop
            XAchseInneresSchleife:
            for XAchseInneresSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / 2  loop
               
               FelderwerteFestlegen.KartenfelderBewerten (GenerierungExtern => True,
                                                          KoordinatenExtern => (-2, YAchseInneresSchleifenwert, XAchseInneresSchleifenwert));
               
            end loop XAchseInneresSchleife;
         end loop YAchseInneresSchleife;
         
      end PlanetenInneresUntenLinks;
      
      
      
      task body PlanetenInneresUntenRechts
      is begin
         
         YAchseInneresSchleife:
         for YAchseInneresSchleifenwert in (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisrand) / 2 + 1 .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisrand loop
            XAchseInneresSchleife:
            for XAchseInneresSchleifenwert in Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / 2 + 1 .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
               
               FelderwerteFestlegen.KartenfelderBewerten (GenerierungExtern => True,
                                                          KoordinatenExtern => (-2, YAchseInneresSchleifenwert, XAchseInneresSchleifenwert));
               
            end loop XAchseInneresSchleife;
         end loop YAchseInneresSchleife;
         
      end PlanetenInneresUntenRechts;
      
      
      
      task body StandardObenRechts
      is begin
         
         YAchseUnterwasserSchleife:
         for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) + GlobaleKonstanten.Eisrand .. (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisrand) / 2 loop
            XAchseUnterwasserSchleife:
            for XAchseSchleifenwert in Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / 2 + 1 .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
               
               FelderwerteFestlegen.KartenfelderBewerten (GenerierungExtern => True,
                                                          KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert));
               
            end loop XAchseUnterwasserSchleife;
         end loop YAchseUnterwasserSchleife;
         
      end StandardObenRechts;
      
      
      
      task body StandardUntenLinks
      is begin
         
         YAchseUnterwasserSchleife:
         for YAchseSchleifenwert in (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisrand) / 2 + 1 .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisrand loop
            XAchseUnterwasserSchleife:
            for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / 2 loop
               
               FelderwerteFestlegen.KartenfelderBewerten (GenerierungExtern => True,
                                                          KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert));
               
            end loop XAchseUnterwasserSchleife;
         end loop YAchseUnterwasserSchleife;
         
      end StandardUntenLinks;
      
      
      
      task body StandardUntenRechts
      is begin
         
         YAchseUnterwasserSchleife:
         for YAchseSchleifenwert in (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisrand) / 2 + 1 .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisrand loop
            XAchseUnterwasserSchleife:
            for XAchseSchleifenwert in Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / 2 + 1 .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
               
               FelderwerteFestlegen.KartenfelderBewerten (GenerierungExtern => True,
                                                          KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert));
               
            end loop XAchseUnterwasserSchleife;
         end loop YAchseUnterwasserSchleife;
         
      end StandardUntenRechts;


      
   begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) + GlobaleKonstanten.Eisrand .. (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisrand) / 2 loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / 2 loop
            
            FelderwerteFestlegen.KartenfelderBewerten (GenerierungExtern => True,
                                                       KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert));
               
         end loop XAchseSchleife;
      end loop YAchseSchleife;
   
   end KartenfelderBewerten;   

end KartenfelderBewerten;
