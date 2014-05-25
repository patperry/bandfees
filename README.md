
This data comes from the priceonomics story
[How much does it cost to book your favorite band?](http://priceonomics.com/how-much-does-it-cost-to-book-your-favorite-band/)

From the original article:

> Thanks to [Degy Entertainment](http://degy.com/main/), a booking agency, we
> can give you a rough idea: an anonymous source passed along a list of the
> rates suggested by the artists' agents per show, pre-expense.
> 
> (Note: as a reader pointed out, these are asking prices from a third-party
> booking agency that specializes in college shows; as such, the numbers are
> likely inflated. Actual prices negotiated by many of these performers are
> contingent on a variety of factors.)
> 
> Before you read these lists, a few things should be clarified. First of all,
> they aren't perfect: a few acts are out of place, or suspiciously off --
> we'll try to address these below. You'll also notice that there are a few
> anomalies, and acts that aren't music-related (ie. Myth Busters, who you can
> rent for a mere $100k); Degy books speakers and corporate entertainment acts
> too, and a few slipped into these listings. Lastly, keep in mind that these
> lists aren't comprehensive.

Priceonomics provides the data as a set of images (`raw/10k-1.png`,
`raw/10k-2.png`, etc.).  I downloaded the images, then converted them to text
with [onlineocr.net](http://www.onlineocr.net)'s free optical character
recognition (OCR) service (`ocr/10k-1.txt`, `ocr/10k-2.txt`, etc.).  Then, I
used a text editor and spreadsheet program to reformat and fix errors in the
OCR output (`clean/10k.tsv`, etc.).  Finally I combine the cleaned files into
a single CSV file, `bandfees.csv` using a python script (`bandfees.py`).

